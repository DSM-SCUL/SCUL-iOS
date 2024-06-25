import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class PlaceGuideDetailViewController: BaseViewController<PlaceGuideDetailViewModel> {
    private var isExistReview = true
    let isNavigatedSubject = BehaviorSubject<Bool>(value: false)
    private let bookmarkButtonDidClicked = PublishRelay<String>()
    private let navigateToReviewButtonDidClicked = PublishRelay<Void>()
    private var id: String = ""

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
    private let addressLabel = SculDetailLabel(menuText: "주소").then {
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
        $0.estimatedRowHeight = 109
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
    }

    private let linkButtomDividerView = UIView().then {
        $0.backgroundColor = UIColor.Gray50
    }

    private let reviewLabel = UILabel().then {
        $0.labelSetting(text: "혹시 이 곳을 다녀오셨나요?", font: .caption1)
        $0.textColor = .black
    }
    private let navigateToReviewButton = UIButton().then {
        $0.buttonSetting(text: "리뷰 작성하기", font: .caption1, titleColor: .white)
        $0.backgroundColor = .Main300
        $0.layer.cornerRadius = 8
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
            addressLabel,
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
            reviewTableView,
            linkButtomDividerView,
            reviewLabel,
            navigateToReviewButton
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
            $0.bottom.equalTo(navigateToReviewButton.snp.bottom).offset(20)
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
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        runingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(16)
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
        linkButtomDividerView.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.top.equalTo(detailInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(linkButtomDividerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        navigateToReviewButton.snp.makeConstraints {
            $0.top.equalTo(linkButtomDividerView.snp.bottom).offset(16)
            $0.width.equalTo(111)
            $0.height.equalTo(27)
            $0.trailing.equalToSuperview().inset(20)
        }
    }

    public override func bind() {
        let input = PlaceGuideDetailViewModel.Input(
            viewAppear: self.viewDidLoadPublisher,
            bookmarkButtonDidTap: bookmarkButtonDidClicked,
            navigateToReviewButtonDidClicked: navigateToReviewButtonDidClicked
        )

        let output = viewModel.transform(input)

        output.cultureDetailData.asObservable()
            .bind { [self] (detailInfo: CultureDetailEntity) in
                let url = URL(string: detailInfo.imageUrl)!
                placeImageView.loadImage(from: url)
                placeNameLabel.text = detailInfo.placeName
                phoneNumberLabel.setContentLabel(contentText: detailInfo.phoneNumber)
                addressLabel.setContentLabel(contentText: detailInfo.location)
                var time: String {
                    return "\(detailInfo.serviceStartTime)~\(detailInfo.serviceEndTime)"
                }
                runingTimeLabel.setContentLabel(contentText: time)
                var submitDate: String {
                    return "\(detailInfo.applicationStartDate)~\(detailInfo.applicationEndDate)"
                }
                submitScheduleLabel.setContentLabel(contentText: detailInfo.applicationStartDate)
                var operationalDate: String {
                    return "\(detailInfo.serviceStartDate)~\(detailInfo.serviceEndDate)"
                }
                operationalScheduleLabel.setContentLabel(contentText: operationalDate)
                let isApplicationAble = detailInfo.isApplicationAble
                let location = detailInfo.location
                let tagType = detailInfo.wantedPeople
//                let x = detailInfo.xcoordinate
//                let y = detailInfo.ycoordinate
                let cultureLink = detailInfo.cultureLink

                detailInfoView.setting(
                    isApplicationAble: isApplicationAble,
                    location: location,
                    tagType: tagType,
//                    x: x,
//                    y: y,
                    cultureLink: cultureLink
                )
                self.id = detailInfo.id
            }
            .disposed(by: disposeBag)

        output.reviewData.asObservable()
            .bind(
                to: reviewTableView.rx.items(
                    cellIdentifier: ReviewTableViewCell.identifier,
                    cellType: ReviewTableViewCell.self
                )) { _, element, cell in
                    cell.adapt(model: element)
                }
                .disposed(by: disposeBag)
    }

    public override func configureViewController() {
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
                self.bookmarkButtonDidClicked.accept(self.id)
                self.isActivateBookmark.toggle()
            })
            .disposed(by: disposeBag)

        navigateToReviewButton.rx.tap
            .subscribe(onNext: {
                self.navigateToReviewButtonDidClicked.accept(())
            })
            .disposed(by: disposeBag)
    }

    public override func configureNavigation() {
    }

//    override func viewDidAppear(_ animated: Bool) {
//        reviewTableView.reloadData()
//    }
}
