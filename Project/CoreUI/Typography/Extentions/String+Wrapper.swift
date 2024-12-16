import UIKit

extension Optional where Wrapped == String {

    var count: Int {
        switch self {
        case .none:
            return 0
        case .some(let wrapped):
            return wrapped.count
        }
    }
}
