import UIKit
import SnapKit
import Then

public final class SculTagButton: BaseView {
    private let button = UIButton().then {
        $0.buttonSetting(
            text: "안녕~",
            font: .label2,
            titleColor: .black
        )
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.clipsToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    public init(
        tagType: Int
    ) {
        super.init()
        switch tagType {
        case 1:
            button.setTitle("장애인 ♿️", for: .normal)
            button.layer.borderColor = UIColor.Main500.cgColor
        case 2:
            button.setTitle("유아 👶", for: .normal)
            button.layer.borderColor = UIColor.Main300.cgColor
        case 3:
            button.setTitle("노약자 🧓🏻", for: .normal)
            button.layer.borderColor = UIColor.Main400.cgColor
        default:
            button.setTitle("유아 👶", for: .normal)
            button.layer.borderColor = UIColor.Main300.cgColor
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func addView() {
        self.addSubview(button)
    }

    public override func setLayout() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(34)
        }
    }
}
