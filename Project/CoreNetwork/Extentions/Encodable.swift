import Foundation

extension Encodable {
    func toData(_ keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy? = nil) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy ?? .convertToSnakeCase
        let jsonData = try encoder.encode(self)

        return jsonData
    }

    func toDictionary() throws -> [String: String?] {
        let jsonData = try JSONEncoder().encode(self)
        let jsonDict = try JSONDecoder().decode([String: String?].self, from: jsonData)

        return jsonDict
    }

    func toQueryItems() throws -> [URLQueryItem] {
        let jsonDict = try toDictionary()

        return jsonDict.compactMap { item in
            guard let value = item.value else {
                return nil
            }

            return URLQueryItem(name: item.key, value: value)
        }
    }
}
