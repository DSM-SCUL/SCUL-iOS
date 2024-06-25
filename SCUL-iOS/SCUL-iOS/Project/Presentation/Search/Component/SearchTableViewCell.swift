import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SearchTableViewCell: BaseTableViewCell<CultureListEntity> {
    static let identifier = "SearchTableViewCell"
    private var disposeBag = DisposeBag()
    public var bookmarkButtonDidTap: (() -> Void)?

    private var isActivateBookmark = false {
        didSet {
            var bookmarkImage: UIImage {
                isActivateBookmark ? .BookmarkOn!: .BookmarkOff!
            }
            bookmarkButton.setImage(bookmarkImage, for: .normal)
        }
    }

    var placeImageView = UIImageView().then {
        $0.backgroundColor = .Gray100
        $0.layer.cornerRadius = 4
    }
    var placeTitleLabel = UILabel().then {
        $0.text = "서울 시립 미술관"
        $0.font = UIFont.sb3
    }
    var bookmarkButton = UIButton().then {
        $0.setImage(.bookmarkOff, for: .normal)
    }
    var placeLocationLabel = UILabel().then {
        $0.text = "서울특별시 가정북로 76 우정관"
        $0.font = UIFont.body3
        $0.textColor = .Gray500
    }
    var placeUseGuideLabel = SculPlaceGuideLabel(
        isEnableReservation: true,
        isEnableCostFree: true
    )
    private let typeTagButton = UIButton().then {
        $0.buttonSetting(text: ".....", font: .body3, titleColor: .white)
        $0.backgroundColor = .Main500
        $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        $0.layer.cornerRadius = 12
    }

    override func addView() {
        [
            placeImageView,
            placeTitleLabel,
            bookmarkButton,
            placeLocationLabel,
            placeUseGuideLabel,
            typeTagButton
        ].forEach { contentView.addSubview($0) }
    }

    override func setLayout() {
        placeImageView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(86)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        placeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14.5)
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
        }
        placeLocationLabel.snp.makeConstraints {
            $0.top.equalTo(placeTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(placeTitleLabel.snp.leading)
        }
        placeUseGuideLabel.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.width.equalTo(100)
            $0.top.equalTo(placeLocationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(placeTitleLabel.snp.leading)
        }
        typeTagButton.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(placeUseGuideLabel.snp.bottom).offset(8)
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        bookmarkButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    override func configureView() {
        self.selectionStyle = .none

        bookmarkButton.rx.tap
            .subscribe(onNext: {
                self.bookmarkButtonDidTap?()
                self.isActivateBookmark.toggle()
            })
            .disposed(by: disposeBag)
    }

    public override func adapt(model: CultureListEntity) {
        super.adapt(model: model)
        let url = URL(string: model.imageUrl)!
        placeImageView.loadImage(from: url)
        placeTitleLabel.text = model.placeName
        placeLocationLabel.text = model.location
        placeUseGuideLabel = SculPlaceGuideLabel(
            isEnableReservation: model.isApplicationAble,
            isEnableCostFree: model.isApplicationAble
        )
        typeTagButton.setTitle(model.wantedPeople, for: .normal)
        isActivateBookmark = model.isBookMarked
    }
}
