import UIKit

protocol Builder {
    associatedtype Model = Never

    static func build() -> UIViewController
    static func build(with model: Model) -> UIViewController
}

extension Builder {
    static func build() -> UIViewController {
        fatalError("implement build() in Builder")
    }

    static func build(with model: Model) -> UIViewController {
        fatalError("implement build(with model: Model) in Builder")
    }
}
