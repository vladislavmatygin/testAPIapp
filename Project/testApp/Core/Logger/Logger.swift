import Foundation
import Logging

let logger: Logging.Logger = {
    var logger = Logging.Logger(label: "ios.app")
    logger.logLevel = .info

    return logger
}()

struct Logger {
    private static var didConfigure = false

    static func configure() {
        guard !didConfigure else { return }
        didConfigure = true

        LoggingSystem.bootstrap { label in
            #if DEBUG
                StreamLogHandler.standardOutput(label: label)
            #else
                FirebaseLogHandler(label: label)
            #endif
        }

        var networkLogger = Logging.Logger(label: "ios.network")
        networkLogger.logLevel = .info
    }
}
