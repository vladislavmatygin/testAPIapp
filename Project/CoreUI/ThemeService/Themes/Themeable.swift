import Foundation
import UIKit

public protocol Themeable {
    var userInterfaceStyle: UIUserInterfaceStyle { get }

    // MARK: - Background

    var backgroundBasic: UIColor { get }
    var backgroundAdditionalOne: UIColor { get }
    var backgroundAdditionalOnePressed: UIColor { get }
    var backgroundModalView: UIColor { get }
    var backgroundModalControl: UIColor { get }
    var backgroundError: UIColor { get }
    var backgroundErrorPressed: UIColor { get }
    var backgroundSuccess: UIColor { get }
    var backgroundSuccessPressed: UIColor { get }
    var backgroundAttention: UIColor { get }
    var backgroundAttentionAdd: UIColor { get }
    var backgroundAttentionPressed: UIColor { get }
    var backgroundExtraSurface: UIColor { get }
    var backgroundDividerShadow: UIColor { get }
    var backgroundNavBar: UIColor { get }
    var backgroundBlueGray: UIColor { get }
    var backgroundMessageBG: UIColor { get }
    var backgroundGrey: UIColor { get }
    var backgroundAccent: UIColor { get }
    var backgroundToast: UIColor { get }
    var backgroundForeground: UIColor { get }
    var backgroundForegroundAdd: UIColor { get }
    var backgroundBasicUniform: UIColor { get }
    var backgroundErrorUniform: UIColor { get }
    var backgroundSuccessUniform: UIColor { get }
    var backgroundAttentionAddUniform: UIColor { get }
    var backgroundMessageBGUniform: UIColor { get }
    var backgroundAccentUniform: UIColor { get }

    var textPrimary: UIColor { get }
    var textSecondary: UIColor { get }
    var textPlaceholder: UIColor { get }
    var textMask: UIColor { get }
    var textDisable: UIColor { get }
    var textStatic: UIColor { get }
    var textAccent: UIColor { get }
    var textAccentPressed: UIColor { get }
    var textAccentDisable: UIColor { get }
    var textError: UIColor { get }
    var textErrorPressed: UIColor { get }
    var textErrorDisable: UIColor { get }
    var textSuccess: UIColor { get }
    var textSuccessPressed: UIColor { get }
    var textSuccessDisable: UIColor { get }
    var textAttention: UIColor { get }
    var textAttentionPressed: UIColor { get }
    var textAttentionDisable: UIColor { get }
    var textPrimaryUniform: UIColor { get }
    var textSecondaryUniform: UIColor { get }
    var textStaticUniform: UIColor { get }
    var textAccentUniform: UIColor { get }
    var textErrorUniform: UIColor { get }
    var textSuccessUniform: UIColor { get }
    var textAttentionUniform: UIColor { get }

    var elementPrimary: UIColor { get }
    var elementSecondary: UIColor { get }
    var elementAdditional: UIColor { get }
    var elementAdditionalTwo: UIColor { get }
    var elementDisable: UIColor { get }
    var elementBarDivider: UIColor { get }
    var elementStatic: UIColor { get }
    var elementContrast: UIColor { get }
    var elementError: UIColor { get }
    var elementErrorPressed: UIColor { get }
    var elementErrorDisable: UIColor { get }
    var elementSuccess: UIColor { get }
    var elementSuccessPressed: UIColor { get }
    var elementSuccessDisable: UIColor { get }
    var elementAttention: UIColor { get }
    var elementAttentionPressed: UIColor { get }
    var elementAttentionDisable: UIColor { get }
    var elementAccent: UIColor { get }
    var elementAccentPressed: UIColor { get }
    var elementAccentDisable: UIColor { get }
    var elementCashback: [UIColor] { get }
    var elementAccentAdd: UIColor { get }
    var elementBlueGray: UIColor { get }
    var elementPrimaryUniform: UIColor { get }
    var elementSecondaryUniform: UIColor { get }
    var elementStaticUniform: UIColor { get }
    var elementErrorUniform: UIColor { get }
    var elementSuccessUniform: UIColor { get }
    var elementAttentionUniform: UIColor { get }
    var elementAccentUniform: UIColor { get }
    var elementShadow: UIColor { get }
    var elementCashbackShadow: UIColor { get }

    var special01: UIColor { get }
    var special02: UIColor { get }
    var special03: UIColor { get }
    var special04: UIColor { get }
    var special05: UIColor { get }
    var special06: UIColor { get }
    var special07: UIColor { get }
    var special08: UIColor { get }
    var special09: UIColor { get }
    var special10: UIColor { get }

    var rating900: UIColor { get }
    var rating500: UIColor { get }
    var rating300: UIColor { get }
}
