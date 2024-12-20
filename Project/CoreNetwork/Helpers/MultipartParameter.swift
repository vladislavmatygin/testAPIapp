import Foundation

public enum MultipartParameter {
    public enum Value {
        case image(Data)
        case string(String)
    }

    case data(name: String, filename: String? = nil, _ value: Value)
}

extension [MultipartParameter] {
    func getData(_ boundary: String) -> Data {
        var data = Data()

        for case let .data(name, fileName, value) in self {
            data.append(Data("------\(boundary)\r\n".utf8))

            switch value {
            case let .string(value):
                data.append(Data("Content-Disposition: form-data; name=\"\(name)\"\r\n\n".utf8))
                data.append(Data("\(value)\r\n".utf8))
            case let .image(imageData):
                let fileName = fileName.map { "; filename=\"\($0)\"" } ?? ""
                data.append(Data("Content-Disposition: form-data; name=\"\(name)\"\(fileName)\r\n".utf8))
                data.append(Data("Content-Type: image/png\r\n\r\n".utf8))
                data.append(imageData)
                data.append(Data("\r\n\n".utf8))
            }
        }

        data.append(Data("------\(boundary)--\r\n".utf8))

        return data
    }
}
