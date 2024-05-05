import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MyPageViewController: BaseViewController<MyPageViewModel> {
    private let myReviewButtonDidTap = PublishRelay<Void>()
    private let bookmarkButtonDidTap = PublishRelay<Void>()
    private let logoutButtonDidTap = PublishRelay<Void>()

    private let explainLabel = UILabel().then {
        $0.labelSetting(text: "즐거운 여가시간을 보내는", font: .caption1)
        $0.textColor = .Gray800
    }
    private let nameLabel = UILabel().then {
        $0.labelSetting(text: "강해민", font: .heading3)
        $0.textColor = .black
    }
    private let watchMenuLabel = UILabel().then {
        $0.labelSetting(text: "보기", font: .body2)
        $0.textColor = .Gray500
    }
    private let myReviewButton = UIButton().then {
        $0.setImage(.MyReview, for: .normal)
        $0.buttonSetting(text: "내가 작성한 리뷰", font: .body1, titleColor: .black)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
        $0.contentHorizontalAlignment = .leading
    }
    private let myBookmarkButton = UIButton().then {
        $0.setImage(.BookmarkOn, for: .normal)
        $0.buttonSetting(text: "북마크", font: .body1, titleColor: .black)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        $0.contentHorizontalAlignment = .leading
    }
    private let accountMenuLabel = UILabel().then {
        $0.labelSetting(text: "계정", font: .body2)
        $0.textColor = .Gray500
    }
    private let logoutButton = UIButton().then {
        $0.setImage(.Logout, for: .normal)
        $0.buttonSetting(text: "로그아웃", font: .body1, titleColor: .black)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        $0.contentHorizontalAlignment = .leading
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        [
            explainLabel,
            nameLabel,
            watchMenuLabel,
            myReviewButton,
            myBookmarkButton,
            accountMenuLabel,
            logoutButton
        ].forEach { self.view.addSubview($0) }
    }

    public override func setLayout() {
        explainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(138)
            $0.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(explainLabel)
        }

        watchMenuLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(56)
            $0.leading.equalToSuperview().inset(20)
        }

        myReviewButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(watchMenuLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }

        myBookmarkButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(myReviewButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        accountMenuLabel.snp.makeConstraints {
            $0.top.equalTo(myBookmarkButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }

        logoutButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(accountMenuLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
    }

    public override func bind() {
        let input = MyPageViewModel.Input(
            myReviewButtonDidTap: myReviewButtonDidTap,
            bookmarkButtonDidTap: bookmarkButtonDidTap,
            logoutButtonDidTap: logoutButtonDidTap
        )

        let _ = viewModel.transform(input)
    }

    public override func configureViewController() {
        self.navigationItem.title = "MY"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never

        myReviewButton.rx.tap
            .subscribe(onNext: {
                self.myReviewButtonDidTap.accept(())
            })
            .disposed(by: disposeBag)

        myBookmarkButton.rx.tap
            .subscribe(onNext: {
                self.bookmarkButtonDidTap.accept(())
            })
            .disposed(by: disposeBag)

        logoutButton.rx.tap
            .subscribe(onNext: {
                self.showLogoutAlert()
            })
            .disposed(by: disposeBag)
    }

    public override func configureNavigation() {}

    func showLogoutAlert() {
        let alertController = UIAlertController(title: "로그아웃하시겠습니까?", message: nil, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 로그아웃 동작 수행
            print("로그아웃!")
            self.logoutButtonDidTap.accept(())
        }
        alertController.addAction(confirmAction)

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
