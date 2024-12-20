import Foundation

public struct ApiConfiguratorBuilder {
    public enum ApiVersion: String {
        case v1_0 = "1.0.0"
        case v1_1_0 = "1.1.0"
        case v1_1_1 = "1.1.1"
        case any = "null"
    }

    private struct BaseApiConfigurator: ApiConfigurator {
        let apiPrefix: String
        let apiVersion: String
        let method: HTTPMethod
        let path: String
        let contentType: ContentType
        let headerParameters: Encodable?
        let bodyParameters: Encodable?
        let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy?
        let multipartParameters: [MultipartParameter]?
        let queryParameters: Encodable?
        let timeout: Double?
    }

    private var apiPrefix: String = "json"
    private var apiVersion: String = ApiVersion.v1_0.rawValue
    private var method: HTTPMethod = .get
    private var contentType: ContentType = .json
    private var path: String = ""
    private var headerParameters: Encodable?
    private var bodyParameters: Encodable?
    private var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy?
    private var multipartParameters: [MultipartParameter]?
    private var queryParameters: Encodable?
    private var timeout: Double?

    public init() {}

    public func apiVersion(_ version: ApiVersion) -> Self {
        var builder = self
        builder.apiVersion = version.rawValue
        return builder
    }

    public func method(_ method: HTTPMethod) -> Self {
        var builder = self
        builder.method = method
        return builder
    }

    public func path(_ path: String) -> Self {
        var builder = self
        builder.path = path
        return builder
    }

    public func header(_ headerParameters: Encodable) -> Self {
        var builder = self
        builder.headerParameters = headerParameters
        return builder
    }

    public func body(_ bodyParameters: Encodable) -> Self {
        var builder = self
        builder.bodyParameters = bodyParameters
        return builder
    }

    public func keyEncodingStrategy(_ keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy) -> Self {
        var builder = self
        builder.keyEncodingStrategy = keyEncodingStrategy
        return builder
    }

    public func multipart(_ multipart: MultipartParameter...) -> Self {
        var builder = self
        builder.multipartParameters = multipart
        return builder
    }

    public func query(_ queryParameters: Encodable) -> Self {
        var builder = self
        builder.queryParameters = queryParameters
        return builder
    }

    public func contentType(_ content: ContentType) -> Self {
        var builder = self
        builder.contentType = content
        return builder
    }

    public func apiPrefix(_ prefix: String) -> Self {
        var builder = self
        builder.apiPrefix = prefix
        return builder
    }

    public func timeout(_ secconds: Double) -> Self {
        var builder = self
        builder.timeout = secconds
        return builder
    }

    public func build() -> ApiConfigurator {
        BaseApiConfigurator(
            apiPrefix: apiPrefix,
            apiVersion: apiVersion,
            method: method,
            path: path,
            contentType: contentType,
            headerParameters: headerParameters,
            bodyParameters: bodyParameters,
            keyEncodingStrategy: keyEncodingStrategy,
            multipartParameters: multipartParameters,
            queryParameters: queryParameters,
            timeout: timeout
        )
    }
}

public extension ApiConfiguratorBuilder {
    init(_ configurator: ApiConfigurator) {
        var builder = ApiConfiguratorBuilder()
        builder.apiVersion = configurator.apiVersion
        builder.method = configurator.method
        builder.contentType = configurator.contentType
        builder.path = configurator.path
        builder.headerParameters = configurator.headerParameters
        builder.bodyParameters = configurator.bodyParameters
        builder.keyEncodingStrategy = configurator.keyEncodingStrategy
        builder.multipartParameters = configurator.multipartParameters
        builder.queryParameters = configurator.queryParameters

        self = builder
    }
}
