import UIKit

public extension UITextField {
    func textFieldSetting(placeholder: String?, font: UIFont, isHide: Bool) {
        self.autocapitalizationType = .none
        self.placeholder = placeholder ?? ""
        self.isSecureTextEntry = isHide
        self.backgroundColor = .Gray50
        self.layer.cornerRadius = 4
        self.font = font
    }

}
