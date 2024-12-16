import UIKit

public final class Font {

    public enum FontType {
        case largeTitle1, largetTitle2
        case title1, title2
        case subtitle1, subtitle2, subtitle3
        case headline
        case body1, body2, body3, body4
        case subhead1, subhead2, subhead3, subhead4
        case caption1, caption2, caption3, caption4, caption5, caption6

        fileprivate var size: CGFloat {
            switch self {
            case .largeTitle1:
                return 32
            case .largetTitle2:
                return 28
            case .title1, .title2:
                return 22
            case .subtitle1, .subtitle2, .subtitle3:
                return 18
            case .headline, .body1, .body2, .body3, .body4:
                return 16
            case .subhead1, .subhead2, .subhead3, .subhead4:
                return 14
            case .caption1, .caption2, .caption3:
                return 12
            case .caption4, .caption5, .caption6:
                return 10
            }
        }

        public var lineHeight: CGFloat {
            switch self {
            case .largeTitle1:
                return 40
            case .largetTitle2:
                return 32
            case .title1, .title2:
                return 28
            case .subtitle1, .subtitle2, .subtitle3,
                    .headline, .body1, .body2, .body3, .body4:
                return 24
            case .subhead2, .subhead3, .subhead4:
                return 20
            case .subhead1, .caption1:
                return 16
            case .caption2, .caption3, .caption4, .caption5, .caption6:
                return 14
            }
        }

        fileprivate var weight: UIFont.Weight {
            switch self {
            case .largeTitle1, .largetTitle2, .title1, .subtitle1, .subhead1, .caption4:
                return .bold
            case .title2, .body1, .body4, .subhead4, .caption1, .caption3, .caption5:
                return .medium
            case .subtitle2, .headline, .subhead2:
                return .semibold
            case .caption2, .subhead3, .body2, .body3, .subtitle3, .caption6:
                return .regular
            }
        }
    }

    public static func getFont(withType type: FontType) -> UIFont {
        return .systemFont(ofSize: type.size, weight: type.weight)
    }
}
