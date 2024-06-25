import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class BookmarkViewController: BaseViewController<BookmarkViewModel> {
    private let bookmarkButtonDidClicked = PublishRelay<String>()
    private let bookmarkLabel = UILabel().then {
        $0.labelSetting(text: "북마크", font: .sb1)
        $0.textColor = .black
    }
    private let bookmarkTableView = UITableView().then {
        $0.register(
            BookmarkTableViewCell.self,
            forCellReuseIdentifier: BookmarkTableViewCell.identifier
        )
        $0.estimatedRowHeight = 110
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.Gray100.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        [
            bookmarkLabel,
            bookmarkTableView
        ].forEach { self.view.addSubview($0) }
    }

    public override func setLayout() {
        bookmarkLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.leading.equalToSuperview().inset(20)
        }

        bookmarkTableView.snp.makeConstraints {
            $0.top.equalTo(bookmarkLabel.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }

    }

    public override func bind() {
        let input = BookmarkViewModel.Input(
            viewAppear: self.viewDidLoadPublisher, bookmarkButtonDidTap: bookmarkButtonDidClicked
        )

        let output = viewModel.transform(input)

        output.bookmarkListData
            .bind(
                to: bookmarkTableView.rx.items(
                    cellIdentifier: BookmarkTableViewCell.identifier,
                    cellType: BookmarkTableViewCell.self
                )) { _, element, cell in
                    cell.adapt(model: element)
                    cell.bookmarkButtonDidTap = {
                        self.bookmarkButtonDidClicked.accept((cell.model!.id))
                    }
                }
                .disposed(by: disposeBag)
    }

    public override func configureViewController() {
    }

    public override func configureNavigation() {}
}
