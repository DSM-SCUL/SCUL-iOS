import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MainViewController: BaseViewController<MainViewModel>, UICollectionViewDelegateFlowLayout {
//    private let collectionViewCellDidTap = PublishRelay<Void>()
    private let bookmarkButtonDidClicked = PublishRelay<String>()
    private let collectionViewCellDidTap = PublishRelay<String>()
    private let logoImageView = UIImageView().then {
        $0.image = .SculLogo
    }
    private let bannerImageView = UIImageView().then {
        $0.image = .SculBanner
    }
    private let disabledTagButton = SculTagButton(tagType: 1)
    private let babyTagButton = SculTagButton(tagType: 2)
    private let oldTagButton = SculTagButton(tagType: 3)
    private let dividerView = UIView().then {
        $0.backgroundColor = UIColor.Gray100
    }
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.register(
            CollectionViewCustomCell.self,
            forCellWithReuseIdentifier: CollectionViewCustomCell.identifier
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        [
            dividerView,
            bannerImageView,
            disabledTagButton,
            babyTagButton,
            oldTagButton,
            collectionView
        ].forEach { self.view.addSubview($0) }
    }

    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(75)
        }

        bannerImageView.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        disabledTagButton.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(20)
        }
        babyTagButton.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(18)
            $0.leading.equalTo(disabledTagButton.snp.trailing).offset(12)
        }
        oldTagButton.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(18)
            $0.leading.equalTo(babyTagButton.snp.trailing).offset(12)
        }

        dividerView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(disabledTagButton.snp.bottom).offset(12)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

    public override func bind() {
        let input = MainViewModel.Input(
            viewAppear: self.viewDidLoadPublisher,
            bookmarkButtonDidTap: bookmarkButtonDidClicked,
            collectionViewCellDidTap: collectionViewCellDidTap
        )

        let output = viewModel.transform(input)

        output.cultureListData
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: CollectionViewCustomCell.identifier,
                    cellType: CollectionViewCustomCell.self
                )) { _, element, cell in
                    cell.adapt(model: element)
                    cell.bookmarkButtonDidTap = {
                        self.bookmarkButtonDidClicked.accept((cell.model!.id))
                    }
                }
                .disposed(by: disposeBag)
    }

    public override func configureViewController() {
        collectionView.delegate = self
        collectionView.rx.modelSelected(CultureListEntity.self)
            .asObservable()
            .map {
                self.collectionViewCellDidTap.accept($0.id)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.showTabbar()
    }

    public override func configureNavigation() {
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: logoImageView)
        ]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
