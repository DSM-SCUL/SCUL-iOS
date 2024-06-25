import UIKit
import SnapKit
import Then

public class ListEmptyView: BaseView {
    private let emptyImageView = UIImageView().then {
        $0.image = UIImage.SearchEmpty
    }
    private let titleLabel = UILabel().then {
        $0.labelSetting(text: "검색 결과가 없습니다.", font: .sb1)
        $0.textColor = .Gray900
    }

    public override func addView() {
        [
            emptyImageView,
            titleLabel
        ].forEach { self.addSubview($0) }
    }

    public override func setLayout() {
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(150)
            $0.width.equalTo(190)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
