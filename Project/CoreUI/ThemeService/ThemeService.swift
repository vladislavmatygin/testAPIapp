import UIKit

public var theme: Themeable {
    ThemeService.shared.themeable
}

public class ThemeService {
    // MARK: - Properties

    public static let shared = ThemeService()

    public var themeable: Themeable

    // MARK: - Init

    private init() {
        themeable = LightTheme()
    }
}
