import Foundation

public struct APILogger {
    public enum Log {
        case debug(String)
        case info(String)
        case notice(String)
        case error(Error)
    }

    // MARK: - Properties

    private static var logHandler = { (log: Log) in
        switch log {
        case let .debug(message):
            print("🔵 \(message)")
        case let .info(message):
            print("🟢 \(message)")
        case let .notice(message):
            print("🟡 \(message)")
        case let .error(error):
            print("🔴 \(error.localizedDescription)")
        }
    }

    // MARK: - Public methods

    public static func configure(_ logHandler: @escaping (Log) -> Void) {
        self.logHandler = logHandler
    }

    // MARK: - Internal methods

    static func debug(_ message: String) {
        logHandler(.debug(message))
    }

    static func info(_ message: String) {
        logHandler(.info(message))
    }

    static func notice(_ message: String) {
        logHandler(.notice(message))
    }

    static func error(_ error: Error) {
        logHandler(.error(error))
    }
}
