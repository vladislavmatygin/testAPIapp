import UIKit

public final class LightTheme: Themeable {
    public init() {}

    public var userInterfaceStyle: UIUserInterfaceStyle { .light }
    public var preferedStatusBarStyle: UIStatusBarStyle { .darkContent }

    public var backgroundBasic: UIColor { UIColor(hex: "#FFFFFF") }
    public var backgroundAdditionalOne: UIColor { UIColor(hex: "#F2F2F2") }
    public var backgroundAdditionalOnePressed: UIColor { UIColor(hex: "#E6E6E6") }
    public var backgroundModalView: UIColor { UIColor(hex: "#1C1C1C").withAlphaComponent(0.4) }
    public var backgroundModalControl: UIColor { UIColor(hex: "#FFFFFF").withAlphaComponent(0.5) }
    public var backgroundError: UIColor { UIColor(hex: "#FFEBEA") }
    public var backgroundErrorPressed: UIColor { UIColor(hex: "#FFD8D6") }
    public var backgroundSuccess: UIColor { UIColor(hex: "#ECF9F1") }
    public var backgroundSuccessPressed: UIColor { UIColor(hex: "#DAF2E4") }
    public var backgroundAttention: UIColor { UIColor(hex: "#FFEFD7") }
    public var backgroundAttentionAdd: UIColor { UIColor(hex: "#FFF6E6") }
    public var backgroundAttentionPressed: UIColor { UIColor(hex: "#FFDFAF") }
    public var backgroundExtraSurface: UIColor { UIColor(hex: "#FFFFFF") }
    public var backgroundDividerShadow: UIColor { UIColor(hex: "#353843").withAlphaComponent(0.3) }
    public var backgroundNavBar: UIColor { UIColor(hex: "#FFFFFF").withAlphaComponent(0.6) }
    public var backgroundBlueGray: UIColor { UIColor(hex: "#F1F3FB") }
    public var backgroundMessageBG: UIColor { UIColor(hex: "#DFEEFF") }
    public var backgroundGrey: UIColor { UIColor(hex: "#7F7F7F").withAlphaComponent(0.4) }
    public var backgroundAccent: UIColor { UIColor(hex: "#FFF3F2") }
    public var backgroundToast: UIColor { UIColor(hex: "#1C1C1C").withAlphaComponent(0.8) }
    public var backgroundForeground: UIColor { UIColor(hex: "#FFFFFF") }
    public var backgroundForegroundAdd: UIColor { UIColor(hex: "#FFFFFF") }
    public var backgroundBasicUniform: UIColor { UIColor(hex: "#FFFFFF") }
    public var backgroundErrorUniform: UIColor { UIColor(hex: "#FFEBEA") }
    public var backgroundSuccessUniform: UIColor { UIColor(hex: "#ECF9F1") }
    public var backgroundAttentionAddUniform: UIColor { UIColor(hex: "#FFF6E6") }
    public var backgroundMessageBGUniform: UIColor { UIColor(hex: "#DFEEFF") }
    public var backgroundAccentUniform: UIColor { UIColor(hex: "#FFF3F2") }

    public var textPrimary: UIColor { UIColor(hex: "#1C1C1C") }
    public var textSecondary: UIColor { UIColor(hex: "4D4D4D") }
    public var textPlaceholder: UIColor { UIColor(hex: "808080") }
    public var textMask: UIColor { UIColor(hex: "#A6A6A6") }
    public var textDisable: UIColor { UIColor(hex: "#CCCCCC") }
    public var textStatic: UIColor { UIColor(hex: "#FDFDFD") }
    public var textAccent: UIColor { UIColor(hex: "#EE204D") }
    public var textAccentPressed: UIColor { UIColor(hex: "#A61636") }
    public var textAccentDisable: UIColor { UIColor(hex: "#FF809B") }
    public var textError: UIColor { UIColor(hex: "#FF0E00") }
    public var textErrorPressed: UIColor { UIColor(hex: "#B20900") }
    public var textErrorDisable: UIColor { UIColor(hex: "#FF8680") }
    public var textSuccess: UIColor { UIColor(hex: "#00B23C") }
    public var textSuccessPressed: UIColor { UIColor(hex: "#007327") }
    public var textSuccessDisable: UIColor { UIColor(hex: "#8DD9A6") }
    public var textAttention: UIColor { UIColor(hex: "#FFAA00") }
    public var textAttentionPressed: UIColor { UIColor(hex: "#B27700") }
    public var textAttentionDisable: UIColor { UIColor(hex: "#FFD480") }
    public var textPrimaryUniform: UIColor { UIColor(hex: "#1C1C1C") }
    public var textSecondaryUniform: UIColor { UIColor(hex: "#4D4D4D") }
    public var textStaticUniform: UIColor { UIColor(hex: "#FDFDFD") }
    public var textAccentUniform: UIColor { UIColor(hex: "#EE204D") }
    public var textErrorUniform: UIColor { UIColor(hex: "#FF0E00") }
    public var textSuccessUniform: UIColor { UIColor(hex: "#00B23C") }
    public var textAttentionUniform: UIColor { UIColor(hex: "#FFAA00") }

    public var elementPrimary: UIColor { UIColor(hex: "#1C1C1C") }
    public var elementSecondary: UIColor { UIColor(hex: "#4D4D4D") }
    public var elementAdditional: UIColor { UIColor(hex: "#808080") }
    public var elementAdditionalTwo: UIColor { UIColor(hex: "#B3B3B3") }
    public var elementDisable: UIColor { UIColor(hex: "#E6E6E6") }
    public var elementBarDivider: UIColor { UIColor(hex: "#FFFFFF").withAlphaComponent(0) }
    public var elementStatic: UIColor { UIColor(hex: "#FDFDFD") }
    public var elementContrast: UIColor { UIColor(hex: "#FFFFFF") }
    public var elementError: UIColor { UIColor(hex: "#FF0E00") }
    public var elementErrorPressed: UIColor { UIColor(hex: "#B20900") }
    public var elementErrorDisable: UIColor { UIColor(hex: "#E58785") }
    public var elementSuccess: UIColor { UIColor(hex: "#00B23C") }
    public var elementSuccessPressed: UIColor { UIColor(hex: "#007327") }
    public var elementSuccessDisable: UIColor { UIColor(hex: "#84D0A7") }
    public var elementAttention: UIColor { UIColor(hex: "#FFAA00") }
    public var elementAttentionPressed: UIColor { UIColor(hex: "#B27700") }
    public var elementAttentionDisable: UIColor { UIColor(hex: "#DEA370") }
    public var elementAccent: UIColor { UIColor(hex: "#EE204D") }
    public var elementAccentPressed: UIColor { UIColor(hex: "#A61636") }
    public var elementAccentDisable: UIColor { UIColor(hex: "#FF809B") }

    public var elementCashback: [UIColor] {
        [UIColor(hex: "#EE204D"), UIColor(hex: "#EE5E20"), UIColor(hex: "#EE204D")]
    }

    public var elementAccentAdd: UIColor { UIColor(hex: "#EE5E20") }
    public var elementBlueGray: UIColor { UIColor(hex: "#F1F3FB") }
    public var elementPrimaryUniform: UIColor { UIColor(hex: "#1C1C1C") }
    public var elementSecondaryUniform: UIColor { UIColor(hex: "#4D4D4D") }
    public var elementStaticUniform: UIColor { UIColor(hex: "#FDFDFD") }
    public var elementErrorUniform: UIColor { UIColor(hex: "#FF0E00") }
    public var elementSuccessUniform: UIColor { UIColor(hex: "#00B23C") }
    public var elementAttentionUniform: UIColor { UIColor(hex: "#FFAA00") }
    public var elementAccentUniform: UIColor { UIColor(hex: "#EE204D") }
    public var elementShadow: UIColor { UIColor(hex: "#142D88") }
    public var elementCashbackShadow: UIColor { UIColor(hex: "#F22525") }

    public var special01: UIColor { UIColor(hex: "#CF8861") }
    public var special02: UIColor { UIColor(hex: "#E1C272") }
    public var special03: UIColor { UIColor(hex: "#BBC451") }
    public var special04: UIColor { UIColor(hex: "#78B16F") }
    public var special05: UIColor { UIColor(hex: "#75C2B9") }
    public var special06: UIColor { UIColor(hex: "#7096C3") }
    public var special07: UIColor { UIColor(hex: "#8F7ACA") }
    public var special08: UIColor { UIColor(hex: "#5F5794") }
    public var special09: UIColor { UIColor(hex: "#8A3E59") }
    public var special10: UIColor { UIColor(hex: "#C94C4C") }

    public var rating900: UIColor { UIColor(hex: "#00B23C") }
    public var rating500: UIColor { UIColor(hex: "#92A449") }
    public var rating300: UIColor { UIColor(hex: "#85855C") }
}
