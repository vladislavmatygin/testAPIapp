import Foundation
import Logging

public enum NetworkError: Error {
    enum HTTPCodes {
        static let serverError = 500..<600
    }

    public enum NetworkStatus: Int {
        case connected
        case notConnected
        case none
    }

    case failedRequest(_ path: String, _ statusCode: Int, _ data: String)
    case authTimeout(Int)
    case timeout(Double, NetworkStatus = .none)
    case noInternetConnection

    public var isServerError: Bool {
        switch self {
        case let NetworkError.failedRequest(_, code, _) where  HTTPCodes.serverError.contains(code):
            true
        default:
            false
        }
    }
}

public final class NetworkService {
    private enum Constants {
        static let numberOfAttempts = 2
    }

    // MARK: - Properties

    private let urlCache = URLCache.shared

    // MARK: - Init

    public init() {
        urlCache.memoryCapacity = 200000000 // 200MB
        urlCache.diskCapacity = 500000000 // 500MB
    }

    // MARK: - Public methods

    public func request<T: Decodable>(with builder: ApiConfigurator) async throws -> T {
        do {
            return try await request(builder: builder, attempt: 0)
        } catch {
            APILogger.error(error)
            throw error
        }
    }

    public func request(with router: ApiConfigurator) async throws -> Data {
        let request = try router.asURLRequest()
        APILogger.info(request.curl())

        let configuration = URLSessionConfiguration.standard(timeout: router.timeout)
        let urlSession = URLSession(configuration: configuration)
        let (data, response) = try await urlSession.data(request: request)

        guard !data.isEmpty else {
            return try incorrectСases(request, response: response, data: data)
        }

        APILogger.debug("Successful request data: \(data))")

        return data
    }

    // MARK: - Private methods

    private func request<T: Decodable>(builder: ApiConfigurator, attempt: Int) async throws -> T {
        let request = try builder.asURLRequest()
        APILogger.info(request.curl())

        let configuration = URLSessionConfiguration.standard(timeout: builder.timeout)
        let urlSession = URLSession(configuration: configuration)
        let data: Data, response: HTTPURLResponse

        do {
            (data, response) = try await urlSession.data(request: request)
        } catch {
            switch error {
            case let error as NSError where error.domain == NSURLErrorDomain &&
                error.code == NSURLErrorTimedOut:

                let reachability = Reachability.shared

                throw NetworkError.timeout(
                    builder.timeout ?? 30,
                    reachability.status == .connected ? .connected : .notConnected
                )
            default:
                throw error
            }
        }

        guard !data.isEmpty else {
            return try incorrectСases(request, response: response, data: data)
        }

        switch response.statusCode {
        case 200, 201, 202, 204:
            APILogger.debug("Successful request data: \(data.toString())")

            return try data.convertTo(T.self)
        case 429:
            let timeout = 300

            APILogger.info("We'll have to wait a little. Timeout: \(timeout)")

            throw NetworkError.authTimeout(timeout)
        case 403:
            APILogger.notice("Unauthorized error. Need to login")
            let attempt = attempt + 1

            guard attempt < Constants.numberOfAttempts else {
                throw NetworkError.failedRequest(builder.path, response.statusCode, "attempt: \(attempt)")
            }

            APILogger.notice("Retrying to: \(builder.path), attempt: \(attempt)")

            let newBuilder = ApiConfiguratorBuilder()
                .build()

            return try await self.request(builder: newBuilder, attempt: attempt)
        default:
            return try incorrectСases(request, response: response, data: data)
        }
    }

    func incorrectСases<T: Decodable>(_ request: URLRequest, response: HTTPURLResponse, data: Data) throws -> T {
        let path = request.url?.path ?? ""
        let statusCode = response.statusCode

        func cacheData() throws -> Data {
            guard let data = self.cacheData(request) else {
                throw NetworkError.failedRequest(path, statusCode, data.isEmpty ? "Data is empty" : data.toString())
            }

            return data
        }

        switch statusCode {
        case 400, 403, 404, 405, 408, 409, 415:
            APILogger.notice("Something went wrong on device side. Router path: \(path). Status code: \(statusCode)")

            return try cacheData().convertTo(T.self)
        case 500, 502, 522:
            APILogger.notice("Something went wrong on server side. Router path: \(path). Status code: \(statusCode)")

            return try cacheData().convertTo(T.self)
        default:
            let message = if data.isEmpty {
                "Data is empty. Router path: \(path)"
            } else {
                "Unknown error. Router path: \(path). Status code: \(statusCode)"
            }

            APILogger.notice(message)

            return try cacheData().convertTo(T.self)
        }
    }

    private func cacheData(_ request: URLRequest) -> Data? {
        guard let response = urlCache.cachedResponse(for: request) else { return nil }

        APILogger.notice("Taken from cache. Response data: \(response.data.toString())")

        return response.data
    }
}

extension URLSession {
    func data(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                continuation.resume(returning: (data ?? Data(), response as! HTTPURLResponse))
            }.resume()
        }
    }
}

extension URLSessionConfiguration {
    static func standard(timeout: Double? = nil) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.waitsForConnectivity = true
        configuration.timeout = timeout ?? 30

        return configuration
    }

    var timeout: Double {
        get { timeoutIntervalForRequest }
        set {
            timeoutIntervalForRequest = newValue
            timeoutIntervalForResource = newValue
        }
    }
}
