import Foundation

extension Data {
    func convertTo<T: Decodable>(type: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) -> T? {
        return try? convertTo(T.self, keyDecodingStrategy: keyDecodingStrategy)
    }

    func convertTo<T: Decodable>(_ type: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy

        return try decoder.decode(T.self, from: self)
    }

    func toString() -> String {
        let data = (try? JSONSerialization.jsonObject(with: self)).flatMap {
            try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted)
        } ?? self

        return String(bytes: data, encoding: .utf8) ?? "Failed to get string"
    }
}
