import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class ReviewTableViewCell: BaseTableViewCell<PlaceGuideDetailViewModel> {
    static let identifier = "ReviewTableViewCell"
    private var disposeBag = DisposeBag()

    var nameLabel = UILabel().then {
        $0.labelSetting(text: "강*민", font: .body1)
        $0.textColor = .Gray700
    }
    var dateLabel = UILabel().then {
        $0.labelSetting(text: "2024.04.15", font: .body1)
        $0.textColor = .Gray700
    }
    var contentLabel = UILabel().then {
        $0.labelSetting(text: "어마ㅣㄴㅇㅁㄴㅇㄴ푸ㅏㄴ미우파ㅣ망ㅍ나ㅣ품닢운ㄴㅁㅇㄹㄴㅁㄹㄴㅇㅁㄹㄴㅁㅇㄹㅁㄴㅇㄹㅇㄴㄹㅁㄴㄹㅁㅁ아ㅟ", font: .body2)
        $0.textColor = .black
    }

    override func addView() {
        [
            nameLabel,
            dateLabel,
            contentLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }

    override func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(20)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

    override func configureView() {
    }
}
