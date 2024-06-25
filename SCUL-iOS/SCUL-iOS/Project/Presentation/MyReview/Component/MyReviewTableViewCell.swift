import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MyReviewTableViewCell: BaseTableViewCell<MyReviewListEntity> {
    static let identifier = "MyReviewTableViewCell"
    private var disposeBag = DisposeBag()

    private let placeLabel = UILabel().then {
        $0.labelSetting(text: "서울 시립 미술관에서", font: .caption1)
        $0.textColor = .black
    }
    private let nameLabel = UILabel().then {
        $0.labelSetting(text: "강*민", font: .body1)
        $0.textColor = .Gray700
    }
    private let dateLabel = UILabel().then {
        $0.labelSetting(text: "2024.04.15", font: .body1)
        $0.textColor = .Gray700
    }
    private let contentLabel = UILabel().then {
        $0.labelSetting(text: "..", font: .body2)
        $0.textColor = .black
    }

    override func addView() {
        [
            placeLabel,
            nameLabel,
            dateLabel,
            contentLabel
        ].forEach { contentView.addSubview($0) }
    }

    override func setLayout() {
        placeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(20)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }

    override func configureView() {
        self.selectionStyle = .none
    }

    public override func adapt(model: MyReviewListEntity) {
        self.model = model
        nameLabel.text = model.writer
        placeLabel.text = model.placeName
        dateLabel.text = model.createdAt
        contentLabel.text = model.content
    }
}
