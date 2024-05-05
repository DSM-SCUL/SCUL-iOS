import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class PlaceGuideDetailViewController: BaseViewController<PlaceGuideDetailViewModel> {
    private var isExistReview = true
    private var isActivateBookmark = false {
        didSet {
            var bookmarkImage: UIImage {
                isActivateBookmark ? .BookmarkOn!: .BookmarkOff!
            }
            bookmarkButton.setImage(bookmarkImage, for: .normal)
        }
    }
    private var isNavigated = false  {
        didSet {
            if isNavigated {
                UIView.animate(withDuration: 0.1) { [self] in
                    detailInfoButtonBottomBorder.backgroundColor = .white
                    reviewButtonBottomBorder.backgroundColor = .Main400
                    detailInfoButton.setTitleColor(.Gray500, for: .normal)
                    reviewButton.setTitleColor(.black, for: .normal)

                    if !isExistReview {
                        reviewView.snp.makeConstraints {
                            $0.top.equalTo(detailInfoButtonBottomBorder.snp.bottom).offset(16)
                            $0.leading.trailing.equalToSuperview()
                        }
                        self.detailInfoView.isHidden = true
                        self.reviewTableView.isHidden = true
                        self.reviewView.isHidden = false
                    } else {
                        reviewTableView.snp.makeConstraints {
                            $0.top.equalTo(detailInfoButtonBottomBorder.snp.bottom).offset(16)
                            $0.leading.trailing.bottom.equalToSuperview()
                        }
                        self.detailInfoView.isHidden = true
                        self.reviewView.isHidden = true
                        self.reviewTableView.isHidden = false
                    }
                }
            } else {
                UIView.animate(withDuration: 0.1) { [self] in
                    detailInfoButtonBottomBorder.backgroundColor = .Main400
                    reviewButtonBottomBorder.backgroundColor = .white
                    detailInfoButton.setTitleColor(.black, for: .normal)
                    reviewButton.setTitleColor(.Gray500, for: .normal)

                    detailInfoView.snp.updateConstraints {
                        $0.top.equalTo(detailInfoButtonBottomBorder.snp.bottom).offset(16)
                        $0.leading.trailing.equalToSuperview()
                    }
                    self.reviewView.isHidden = true
                    self.reviewTableView.isHidden = true
                    self.detailInfoView.isHidden = false
                }
            }
        }
    }

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let placeImageView = UIImageView().then {
        $0.backgroundColor = .Gray50
    }
    private let placeNameLabel = UILabel().then {
        $0.labelSetting(text: "서울 시립 미술관", font: .heading3)
    }
    private let bookmarkButton = UIButton().then {
        $0.setImage(.bookmarkOff, for: .normal)
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = UIColor.Gray50
    }

    private let phoneNumberLabel = SculDetailLabel(menuText: "전화번호").then {
        $0.setContentLabel(contentText: "041-1234-5678")
    }
    private let useTimeLabel = SculDetailLabel(menuText: "주소").then {
        $0.setContentLabel(contentText: "종로구, 서울 시립 미술관")
    }
    private let runingTimeLabel = SculDetailLabel(menuText: "이용시간").then {
        $0.setContentLabel(contentText: "8:00~14:00")
    }
    private let submitScheduleLabel = SculDetailLabel(menuText: "접수 일정").then {
        $0.setContentLabel(contentText: "5월 6일 ~ 5월 8일")
    }
    private let operationalScheduleLabel = SculDetailLabel(menuText: "운영 일정").then {
        $0.setContentLabel(contentText: "5월 6일 ~ 5월 8일")
    }

    private let bottomDividerView = UIView().then {
        $0.backgroundColor = UIColor.Gray50
    }

    private let detailInfoButton = UIButton().then {
        $0.buttonSetting(text: "상세 정보", font: .body2, titleColor: .black)
        
    }
    private let reviewButton = UIButton().then {
        $0.buttonSetting(text: "리뷰", font: .body2, titleColor: .Gray500)
    }
    private let detailInfoButtonBottomBorder = UIView().then {
        $0.backgroundColor = .Main400
    }
    private let reviewButtonBottomBorder = UIView()
    private var detailInfoView = DetailInfoView()
    private let reviewView = ReviewView()
    private let reviewTableView = UITableView().then {
        $0.register(
            ReviewTableViewCell.self,
            forCellReuseIdentifier: ReviewTableViewCell.identifier
        )
//        $0.separatorStyle = .none
        $0.estimatedRowHeight = 109
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            placeImageView,
            placeNameLabel,
            bookmarkButton,
            dividerView,
            phoneNumberLabel,
            useTimeLabel,
            runingTimeLabel,
            submitScheduleLabel,
            operationalScheduleLabel,
            bottomDividerView,
            detailInfoButton,
            reviewButton,
            detailInfoButtonBottomBorder,
            reviewButtonBottomBorder,
            detailInfoView,
            reviewView,
            reviewTableView
        ].forEach { self.contentView.addSubview($0) }
    }

    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaInsets)
            $0.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(detailInfoView.snp.bottom).offset(20)
        }

        placeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(390)
        }

        placeNameLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }

        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(14.5)
            $0.trailing.equalToSuperview().inset(20)
        }

        dividerView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }

        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        useTimeLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        runingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(useTimeLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        submitScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(runingTimeLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        operationalScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(submitScheduleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }

        bottomDividerView.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.top.equalTo(operationalScheduleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }

        detailInfoButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalTo(bottomDividerView.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
        }
        reviewButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalTo(bottomDividerView.snp.bottom).offset(24)
            $0.leading.equalTo(detailInfoButton.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        detailInfoButtonBottomBorder.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(detailInfoButton.snp.bottom).offset(5)
            $0.leading.equalTo(detailInfoButton.snp.leading)
            $0.trailing.equalTo(detailInfoButton.snp.trailing)
        }
        reviewButtonBottomBorder.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(reviewButton.snp.bottom).offset(5)
            $0.leading.equalTo(reviewButton.snp.leading)
            $0.trailing.equalTo(reviewButton.snp.trailing)
        }
        detailInfoView.snp.makeConstraints {
            $0.top.equalTo(detailInfoButtonBottomBorder.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }

    public override func bind() {}

    public override func configureViewController() {
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        reviewTableView.estimatedSectionHeaderHeight = 0

        detailInfoButton.rx.tap
            .subscribe(onNext: {
                self.isNavigated.toggle()
            })
            .disposed(by: disposeBag)

        reviewButton.rx.tap
            .subscribe(onNext: {
                self.isNavigated.toggle()
            })
            .disposed(by: disposeBag)

        bookmarkButton.rx.tap
            .subscribe(onNext: {
                self.isActivateBookmark.toggle()
            })
            .disposed(by: disposeBag)
    }

    public override func configureNavigation() {
        
    }

    override func viewDidAppear(_ animated: Bool) {
        reviewTableView.reloadData()
    }

    func setDetailInfoButton() {
        
    }

    func setReviewButton() {
        
    }
}

extension PlaceGuideDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as! ReviewTableViewCell

        return cell
    }
    
    
}
