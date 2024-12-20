import Combine
import Foundation
import SystemConfiguration

// https://developer.apple.com/library/archive/samplecode/Reachability/Introduction/Intro.html
public class Reachability {
    public enum Status: Int {
        case connected
        case notConnected
    }

    // MARK: - Properties

    public static let shared = Reachability()
    public var status: Status { _statusSubject.value }
    public private(set) lazy var statusSubject = _statusSubject.removeDuplicates().eraseToAnyPublisher()

    private var _statusSubject: CurrentValueSubject<Status, Never>

    // MARK: - Init

    private init() {
        var addr = sockaddr()
        addr.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        addr.sa_family = sa_family_t(AF_INET)

        guard let reachability = SCNetworkReachabilityCreateWithAddress(nil, &addr) else {
            fatalError()
        }

        _statusSubject = CurrentValueSubject(Reachability.getStatus(reachability: reachability))

        Reachability.setCallback(reachability: reachability)
    }

    // MARK: - Private methods

    private static func getStatus(reachability: SCNetworkReachability) -> Status {
        var flags: SCNetworkReachabilityFlags = []
        guard SCNetworkReachabilityGetFlags(reachability, &flags) else { return .notConnected }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection ? .connected : .notConnected
    }

    private static func setCallback(reachability: SCNetworkReachability) {
        let reachabilityCallback: SCNetworkReachabilityCallBack = { reachability, _, _ in
            Reachability.shared._statusSubject.send(Reachability.getStatus(reachability: reachability))
        }

        guard SCNetworkReachabilitySetCallback(reachability, reachabilityCallback, nil) else { return }

        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
    }
}
