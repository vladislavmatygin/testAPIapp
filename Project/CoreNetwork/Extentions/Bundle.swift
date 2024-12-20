import UIKit

extension Bundle {

    var releaseVersionNumber: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }

    var buildVersionNumber: String {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }

    func infoForKey(_ key: String) -> String? {
        return object(forInfoDictionaryKey: key) as? String
    }
}
