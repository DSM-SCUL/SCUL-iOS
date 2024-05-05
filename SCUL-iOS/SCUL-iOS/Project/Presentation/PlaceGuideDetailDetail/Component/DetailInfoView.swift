import UIKit
import SnapKit
import Then
import MapKit
import RxSwift
import RxCocoa

public final class DetailInfoView: BaseView {
    private let disposeBag = DisposeBag()
    private let disabledTagButton = SculTagButton(tagType: 1)
    private let babyTagButton = SculTagButton(tagType: 2)
    private let oldTagButton = SculTagButton(tagType: 3)
    private let dividerView = UIView().then {
        $0.backgroundColor = .Gray50
    }
    private let amountLabel = UILabel().then {
        $0.labelSetting(text: "이용료", font: .caption1)
        $0.textColor = .black
    }
    private let amountView = UIButton().then {
        $0.backgroundColor = .Main400
        $0.buttonSetting(text: "무료", font: .caption1, titleColor: .white)
        $0.layer.cornerRadius = 8
    }
    private let locationTitleLabel = UILabel().then {
        $0.labelSetting(text: "위치보기", font: .caption1)
    }
    private let locationDetailLabel = UILabel().then {
        $0.labelSetting(text: "서울특별시 가정북로 76 우정관", font: .caption2)
        $0.textColor = UIColor.Gray900
    }
    private let mapView = MKMapView().then {
        $0.showsUserLocation = true
        $0.mapType = .standard
        $0.layer.cornerRadius = 8
    }
    private let mapBottomDivider = UIView().then {
        $0.backgroundColor = .Gray50
    }
    private let placeLinkTitleLabel = UILabel().then {
        $0.labelSetting(text: "더 자세한 정보는 홈페이지 링크를 확인하세요!", font: .body2)
    }
//    private let placeLinkLabel = UILabel().then {
//        $0.labelSetting(text: "https://github.com/ray3238", font: .caption2)
//        $0.textColor = UIColor.Main600
//    }
    private let placeLinkButton = UIButton().then {
        $0.buttonSetting(text: "https://github.com/ray3238", font: .caption2, titleColor: .Main600)
    }

    public override init( ) {
        super.init()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func addView() {
        [
            disabledTagButton,
            babyTagButton,
            oldTagButton,
            dividerView,
            amountLabel,
            amountView,
            locationTitleLabel,
            locationDetailLabel,
            mapView,
            mapBottomDivider,
            placeLinkTitleLabel,
            placeLinkButton
        ].forEach { self.addSubview($0) }
    }

    public override func setLayout() {
        disabledTagButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(85)
        }
        babyTagButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(disabledTagButton.snp.trailing).offset(12)
            $0.width.equalTo(80)
        }
        oldTagButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(babyTagButton.snp.trailing).offset(12)
            $0.width.equalTo(85)
        }
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(disabledTagButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }

        amountLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        amountView.snp.makeConstraints {
            $0.width.equalTo(52)
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }

        locationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(amountView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        locationDetailLabel.snp.makeConstraints {
            $0.top.equalTo(amountView.snp.bottom).offset(34.5)
            $0.trailing.equalToSuperview().inset(20)
        }
        mapView.snp.makeConstraints {
            $0.top.equalTo(locationTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(160)
        }
        mapBottomDivider.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.top.equalTo(mapView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
        placeLinkTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mapBottomDivider.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        placeLinkButton.snp.makeConstraints {
            $0.top.equalTo(placeLinkTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

    public override func configureView() {
        placeLinkButton.rx.tap
            .subscribe(onNext: {
                print("placeLinkButtonClicked!")
            })
            .disposed(by: disposeBag)
    }
}
