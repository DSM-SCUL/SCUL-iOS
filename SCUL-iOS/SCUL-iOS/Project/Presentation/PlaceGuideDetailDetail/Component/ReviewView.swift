import UIKit
import SnapKit
import Then
import MapKit
import RxSwift
import RxCocoa

public final class ReviewView: BaseView {
    private let disposeBag = DisposeBag()

    private let reviewEmptyLabel = UILabel().then {
        $0.labelSetting(text: "리뷰가 없습니다.", font: .body1)
    }
    private let reviewWriteButton = UIButton().then {
        $0.buttonSetting(text: "리뷰 작성하기", font: .body1, titleColor: .white)
        $0.backgroundColor = .Main400
        $0.layer.cornerRadius = 8
    }

    public override init( ) {
        super.init()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func addView() {
        [
            reviewEmptyLabel,
            reviewWriteButton
        ].forEach { self.addSubview($0) }
    }

    public override func setLayout() {
        reviewEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(65)
            $0.centerX.equalToSuperview()
        }

        reviewWriteButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(reviewEmptyLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(95)
        }
    }

    public override func configureView() {}
}
