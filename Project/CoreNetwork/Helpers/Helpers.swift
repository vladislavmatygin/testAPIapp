import Foundation

public struct Environment {
    public static let rootURL: String = {
       "https://api.spotify.com/v1/"
    }()

    public static let accessToken: String = {
       "Bearer BQDsMazx_qzNV0ZQyhxPcsSo9byRd4wo6dGxxwCms2wPumEjpi9rgwmE96Rrc-yY8UCnPsy_th4tiYbNZ5W-ruT9yVK2Rr1N77CqOkC-NJOFNQTt5mo"
    }()
}

public enum ContentType: String {
    case multipart = "multipart/form-data"
    case json = "application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
    case ifNoneMatch = "If-None-Match"
    case userAgent = "User-Agent"
    case platform = "api-platform"
    case apiVersion = "api-version"
    case token = "api-token"
}

public struct HTTPMethod: RawRepresentable, Hashable {
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let head = HTTPMethod(rawValue: "HEAD")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
