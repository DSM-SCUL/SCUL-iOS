import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class SearchViewController: BaseViewController<SearchViewModel> {
    private let tableViewCellDidTap = PublishRelay<String>()
    private let bookmarkButtonDidClicked = PublishRelay<String>()
    private let searchButtonDidTap = PublishRelay<String>()
//    let list = BehaviorRelay<[String]>(value: ["ㅁㄴㅇㅁㄴㅇ"])

    private let searchImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = UIColor.Gray400
    }
    private let emptySearchView = ListEmptyView().then {
        $0.isHidden = true
    }
    private let searchTextField = UITextField().then {
        $0.backgroundColor = .Gray50
        $0.placeholder = "문화 생활 검색..."
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 0))
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.layer.cornerRadius = 8
    }
    private let xmarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = UIColor.Gray500
    }

    private let searchTableView = UITableView().then {
        $0.register(
            SearchTableViewCell.self,
            forCellReuseIdentifier: SearchTableViewCell.identifier
        )
        $0.estimatedRowHeight = 110
        $0.rowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        [
            searchTextField,
            searchImageView,
            searchTableView,
            xmarkButton
        ].forEach { self.view.addSubview($0) }

        [
            emptySearchView
        ].forEach { searchTableView.addSubview($0) }
    }

    public override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(13)
            $0.height.equalTo(40)
        }

        searchImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.leading.equalTo(searchTextField.snp.leading).inset(12)
        }

        xmarkButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.trailing.equalTo(searchTextField.snp.trailing).inset(12)
        }

        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        emptySearchView.snp.makeConstraints {
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }

    public override func bind() {
        let input = SearchViewModel.Input(
            viewAppear: self.viewDidLoadPublisher,
            bookmarkButtonDidTap: bookmarkButtonDidClicked,
            tableViewCellDidTap: tableViewCellDidTap,
            searchButtonDidTap: searchButtonDidTap
        )

        let output = viewModel.transform(input)

        output.cultureListData
            .bind(
                to: searchTableView.rx.items(
                    cellIdentifier: SearchTableViewCell.identifier,
                    cellType: SearchTableViewCell.self
                )) { _, element, cell in
                    cell.adapt(model: element)
                    cell.bookmarkButtonDidTap = {
                        self.bookmarkButtonDidClicked.accept((cell.model!.id))
                    }
                }
                .disposed(by: disposeBag)
    }

    public override func configureViewController() {
        searchTextField.delegate = self
        searchTableView.allowsSelection = true
        searchTableView.estimatedSectionHeaderHeight = 0

//        list.asObservable()
//            .subscribe(onNext: {
//                self.emptySearchView.isHidden = !$0.isEmpty
//            })
//            .disposed(by: disposeBag)

        xmarkButton.rx.tap
            .subscribe(onNext: {
                self.searchTextField.text = ""
            })
            .disposed(by: disposeBag)

        searchTableView.rx.modelSelected(CultureListEntity.self)
            .asObservable()
            .map {
                self.tableViewCellDidTap.accept($0.id)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.showTabbar()
    }

    public override func configureNavigation() {}
}

extension SearchViewController: UITextFieldDelegate {
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            let title = textField.text
    //        viewModel.searchText = title
            searchButtonDidTap.accept(textField.text ?? "")
            print("enter!")
            self.view.endEditing(true)
            return true
        }
}
//extension SearchViewController: UITextFieldDelegate {
//    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let title = textField.text
////        viewModel.searchText = title
//        searchButtonDidTap.accept(textField.text ?? "")
//        print("enter!")
//        self.view.endEditing(true)
//        return true
//    }
//}
