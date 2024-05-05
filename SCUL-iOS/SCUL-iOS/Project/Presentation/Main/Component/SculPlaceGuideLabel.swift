import UIKit
import SnapKit
import Then

public final class SculPlaceGuideLabel: BaseView {
    private let reservationLabel = UILabel().then {
        $0.labelSetting(text: "예약", font: .body3)
        $0.textColor = .Gray900
    }
    private let reservationStatusLabel = UILabel().then {
        $0.labelSetting(text: "가능", font: .body3)
        $0.textColor = .Main700
    }
    private let costLabel = UILabel().then {
        $0.labelSetting(text: "이용료", font: .body3)
        $0.textColor = .Gray900
    }
    private let costStatusLabel = UILabel().then {
        $0.labelSetting(text: "무료", font: .body3)
        $0.textColor = .Main700
    }

    public init(
        isEnableReservation: Bool,
        isEnableCostFree: Bool
    ) {
        super.init()
        if isEnableReservation {
            reservationStatusLabel.text = "가능"
        } else { reservationStatusLabel.text = "불가능" }

        if isEnableCostFree {
            costStatusLabel.text = "무료"
        } else { costStatusLabel.text = "유료" }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func addView() {
        [
            reservationLabel,
            reservationStatusLabel,
            costLabel,
            costStatusLabel
        ].forEach { self.addSubview($0) }
    }

    public override func setLayout() {
        reservationLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        reservationStatusLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(reservationLabel.snp.trailing).offset(4)
            $0.bottom.equalToSuperview()
        }

        costLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(reservationStatusLabel.snp.trailing).offset(12)
        }
        costStatusLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(costLabel.snp.trailing).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
}
