import UIKit

public extension UILabel {
    func labelSetting(text: String, font: UIFont) {
        self.text = text
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = font
    }
}
