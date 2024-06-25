import UIKit
import SnapKit
import Then

public final class SculDetailLabel: BaseView {
    private let menuLabel = UILabel().then {
        $0.labelSetting(text: "-", font: .body3)
        $0.textColor = .Gray400
        $0.font = UIFont.caption2
    }
    private let contentLabel = UILabel().then {
        $0.labelSetting(text: "-", font: .body3)
        $0.textColor = .black
        $0.font = UIFont.caption2
    }

    public init(
        menuText: String
    ) {
        super.init()
        menuLabel.text = menuText
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func addView() {
        [
            menuLabel,
            contentLabel
        ].forEach { self.addSubview($0) }
    }

    public override func setLayout() {
        menuLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        contentLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }

    public func setContentLabel(contentText: String) {
        contentLabel.text = contentText
    }
}
