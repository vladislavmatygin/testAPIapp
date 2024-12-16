import UIKit

public final class DarkTheme: Themeable {
    public init() {}

    public var userInterfaceStyle: UIUserInterfaceStyle { .dark }
    public var preferedStatusBarStyle: UIStatusBarStyle { .lightContent }

    public var backgroundBasic: UIColor { UIColor(hex: "#1C1C1C") }
    public var backgroundAdditionalOne: UIColor { UIColor(hex: "#2E2E2E") }
    public var backgroundAdditionalOnePressed: UIColor { UIColor(hex: "#494949") }
    public var backgroundModalView: UIColor { UIColor(hex: "#000000").withAlphaComponent(0.8) }
    public var backgroundModalControl: UIColor { UIColor(hex: "#1C1C1C").withAlphaComponent(0.8) }
    public var backgroundError: UIColor { UIColor(hex: "#392B2A") }
    public var backgroundErrorPressed: UIColor { UIColor(hex: "#331614") }
    public var backgroundSuccess: UIColor { UIColor(hex: "#24332A") }
    public var backgroundSuccessPressed: UIColor { UIColor(hex: "#143321") }
    public var backgroundAttention: UIColor { UIColor(hex: "#332D24") }
    public var backgroundAttentionAdd: UIColor { UIColor(hex: "#38342C") }
    public var backgroundAttentionPressed: UIColor { UIColor(hex: "#332714") }
    public var backgroundExtraSurface: UIColor { UIColor(hex: "#000000") }
    public var backgroundDividerShadow: UIColor { UIColor(hex: "#262525").withAlphaComponent(0.5) }
    public var backgroundNavBar: UIColor { UIColor(hex: "#1C1C1C").withAlphaComponent(0.6) }
    public var backgroundBlueGray: UIColor { UIColor(hex: "#000000") }
    public var backgroundMessageBG: UIColor { UIColor(hex: "#313F4E") }
    public var backgroundGrey: UIColor { UIColor(hex: "#7F7F7F").withAlphaComponent(0.4) }
    public var backgroundAccent: UIColor { UIColor(hex: "#39282C") }
    public var backgroundToast: UIColor { UIColor(hex: "#A0A0A0").withAlphaComponent(0.2) }
    public var backgroundForeground: UIColor { UIColor(hex: "#2E2E2E") }
    public var backgroundForegroundAdd: UIColor { UIColor(hex: "#494949") }
    public var backgroundBasicUniform: UIColor { UIColor(hex: "#FFFFFF") }
    public var backgroundErrorUniform: UIColor { UIColor(hex: "#FFEBEA") }
    public var backgroundSuccessUniform: UIColor { UIColor(hex: "#ECF9F1") }
    public var backgroundAttentionAddUniform: UIColor { UIColor(hex: "#FFF6E6") }
    public var backgroundMessageBGUniform: UIColor { UIColor(hex: "#DFEEFF") }
    public var backgroundAccentUniform: UIColor { UIColor(hex: "#FFF3F2") }

    public var textPrimary: UIColor { UIColor(hex: "#FFFFFF") }
    public var textSecondary: UIColor { UIColor(hex: "#CCCCCC") }
    public var textPlaceholder: UIColor { UIColor(hex: "#A6A6A6") }
    public var textMask: UIColor { UIColor(hex: "#808080") }
    public var textDisable: UIColor { UIColor(hex: "#4D4D4D") }
    public var textStatic: UIColor { UIColor(hex: "#1C1C1C") }
    public var textAccent: UIColor { UIColor(hex: "#CC1B42") }
    public var textAccentPressed: UIColor { UIColor(hex: "#A61636") }
    public var textAccentDisable: UIColor { UIColor(hex: "#590C1D") }
    public var textError: UIColor { UIColor(hex: "#BD3C37") }
    public var textErrorPressed: UIColor { UIColor(hex: "#682929") }
    public var textErrorDisable: UIColor { UIColor(hex: "#3D1F22") }
    public var textSuccess: UIColor { UIColor(hex: "#329036") }
    public var textSuccessPressed: UIColor { UIColor(hex: "#234B39") }
    public var textSuccessDisable: UIColor { UIColor(hex: "#1B302A") }
    public var textAttention: UIColor { UIColor(hex: "#BB7A3F") }
    public var textAttentionPressed: UIColor { UIColor(hex: "#5D432F") }
    public var textAttentionDisable: UIColor { UIColor(hex: "#5D432F") }
    public var textPrimaryUniform: UIColor { UIColor(hex: "#1C1C1C") }
    public var textSecondaryUniform: UIColor { UIColor(hex: "#4D4D4D") }
    public var textStaticUniform: UIColor { UIColor(hex: "#FDFDFD") }
    public var textAccentUniform: UIColor { UIColor(hex: "#EE204D") }
    public var textErrorUniform: UIColor { UIColor(hex: "#FF0E00") }
    public var textSuccessUniform: UIColor { UIColor(hex: "#00B23C") }
    public var textAttentionUniform: UIColor { UIColor(hex: "#FFAA00") }

    public var elementPrimary: UIColor { UIColor(hex: "#FFFFFF") }
    public var elementSecondary: UIColor { UIColor(hex: "#CCCCCC") }
    public var elementAdditional: UIColor { UIColor(hex: "#A6A6A6") }
    public var elementAdditionalTwo: UIColor { UIColor(hex: "#808080") }
    public var elementDisable: UIColor { UIColor(hex: "#4D4D4D") }
    public var elementBarDivider: UIColor { UIColor(hex: "#FFFFFF").withAlphaComponent(0.05) }
    public var elementStatic: UIColor { UIColor(hex: "#1C1C1C") }
    public var elementContrast: UIColor { UIColor(hex: "#000000") }
    public var elementError: UIColor { UIColor(hex: "#BD3C37") }
    public var elementErrorPressed: UIColor { UIColor(hex: "#682929") }
    public var elementErrorDisable: UIColor { UIColor(hex: "#3D1F22") }
    public var elementSuccess: UIColor { UIColor(hex: "#329036") }
    public var elementSuccessPressed: UIColor { UIColor(hex: "#234B39") }
    public var elementSuccessDisable: UIColor { UIColor(hex: "#1B302A") }
    public var elementAttention: UIColor { UIColor(hex: "#BB7A3F") }
    public var elementAttentionPressed: UIColor { UIColor(hex: "#5D432F") }
    public var elementAttentionDisable: UIColor { UIColor(hex: "#382C25") }
    public var elementAccent: UIColor { UIColor(hex: "#CC1B42") }
    public var elementAccentPressed: UIColor { UIColor(hex: "#A61636") }
    public var elementAccentDisable: UIColor { UIColor(hex: "#590C1D") }

    public var elementCashback: [UIColor] {
        [UIColor(hex: "#EE204D"), UIColor(hex: "#EE204D"), UIColor(hex: "#EE204D")]
    }

    public var elementAccentAdd: UIColor { UIColor(hex: "#EE5E20") }
    public var elementBlueGray: UIColor { UIColor(hex: "#3B3F49") }
    public var elementPrimaryUniform: UIColor { UIColor(hex: "#1C1C1C") }
    public var elementSecondaryUniform: UIColor { UIColor(hex: "#4D4D4D") }
    public var elementStaticUniform: UIColor { UIColor(hex: "#FDFDFD") }
    public var elementErrorUniform: UIColor { UIColor(hex: "#FF0E00") }
    public var elementSuccessUniform: UIColor { UIColor(hex: "#00B23C") }
    public var elementAttentionUniform: UIColor { UIColor(hex: "#FFAA00") }
    public var elementAccentUniform: UIColor { UIColor(hex: "#EE204D") }
    public var elementShadow: UIColor { UIColor(hex: "#142D88") }
    public var elementCashbackShadow: UIColor { UIColor(hex: "#F22525") }

    public var special01: UIColor { UIColor(hex: "#92654B") }
    public var special02: UIColor { UIColor(hex: "#C0A869") }
    public var special03: UIColor { UIColor(hex: "#A4AB52") }
    public var special04: UIColor { UIColor(hex: "#628B5B") }
    public var special05: UIColor { UIColor(hex: "#6FABA4") }
    public var special06: UIColor { UIColor(hex: "#6985A6") }
    public var special07: UIColor { UIColor(hex: "#8374B0") }
    public var special08: UIColor { UIColor(hex: "#524C79") }
    public var special09: UIColor { UIColor(hex: "#6F394C") }
    public var special10: UIColor { UIColor(hex: "#B15252") }

    public var rating900: UIColor { UIColor(hex: "#34AC39") }
    public var rating500: UIColor { UIColor(hex: "#748047") }
    public var rating300: UIColor { UIColor(hex: "#525243") }
}
