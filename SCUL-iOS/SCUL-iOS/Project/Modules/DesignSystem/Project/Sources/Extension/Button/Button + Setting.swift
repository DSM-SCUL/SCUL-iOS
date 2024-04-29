import UIKit

public extension UIButton {
    func buttonSetting(text: String, font: UIFont, titleColor: UIColor?) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(titleColor ?? .white, for: .normal)
        self.titleLabel?.font = font
    }
}
