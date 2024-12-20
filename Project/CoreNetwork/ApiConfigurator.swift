import Foundation
import UIKit

public enum ApiConfiguratorError: Error {
    case invalidURL(ApiConfigurator)
}

public protocol ApiConfigurator {
    var apiVersion: String { get }
    var method: HTTPMethod { get }
    var apiPrefix: String { get }
    var path: String { get }
    var contentType: ContentType { get }
    var headerParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy? { get }
    var multipartParameters: [MultipartParameter]? { get }
    var queryParameters: Encodable? { get }
    var timeout: Double? { get }
}

extension ApiConfigurator {
    var timeout: Double? {
        nil
    }

    var rootURL: String {
        Environment.rootURL
    }

    private var platform: String {
        "ios"
    }

    private var userAgent: String {
        let width = Int(UIScreen.main.bounds.width)
        let height = Int(UIScreen.main.bounds.height)
        let scale = Int(UIScreen.main.scale)
        let appVersion = Bundle.main.releaseVersionNumber

        return "iOS\(UIDevice.current.systemVersion)/\(width)x\(height)@\(scale)x/appVersion=\(appVersion)"
    }

    func asURLRequest(_ token: String? = nil) throws -> URLRequest {
        guard let baseUrl = URL(string: rootURL + apiPrefix + "/"),
              let url = URL(string: path, relativeTo: baseUrl),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw ApiConfiguratorError.invalidURL(self)
        }

        if let queryItems = try queryParameters?.toQueryItems() {
            urlComponents.queryItems = queryItems
        }

        guard let componentsUrl = urlComponents.url else {
            throw ApiConfiguratorError.invalidURL(self)
        }

        var urlRequest = URLRequest(url: componentsUrl)

        urlRequest.httpMethod = method.rawValue

        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(userAgent, forHTTPHeaderField: HTTPHeaderField.userAgent.rawValue)
        urlRequest.setValue(platform, forHTTPHeaderField: HTTPHeaderField.platform.rawValue)
        urlRequest.setValue(apiVersion, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)

        urlRequest.httpShouldHandleCookies = false
        urlRequest.timeoutInterval = 20
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData

        if let headerParameters = try headerParameters?.toDictionary() {
            headerParameters.forEach { item in
                urlRequest.setValue(item.value, forHTTPHeaderField: item.key)
            }
        }

        if let bodyParameters = try bodyParameters?.toData(keyEncodingStrategy) {
            urlRequest.httpBody = bodyParameters
        }

        if let multipartParameters {
            let boundary = "TestApp\(UUID().uuidString)"
            urlRequest.addValue("boundary=----\(boundary)", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.httpBody = multipartParameters.getData(boundary)
        }

        return urlRequest
    }
}

extension URLRequest {
    func curl() -> String {
        guard let url = url else {
            return ""
        }

        var baseCommand = #"curl "\#(url.absoluteString)""#
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                #if DEBUG
                    command.append("-H '\(key): \(value)'")
                #else
                    command.append("-H '\(key): \(key == "api-token" ? "************************" : value)'")
                #endif
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }
}
