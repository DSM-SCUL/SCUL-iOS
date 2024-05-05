import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class SearchViewController: BaseViewController<SearchViewModel> {
    let list = BehaviorRelay<[String]>(value: ["ㅁㄴㅇㅁㄴㅇ"])
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
//    private let xmarkImageView = UIImageView().then {
//        $0.image = UIImage(systemName: "xmark")
//        $0.tintColor = UIColor.Gray500
//    }

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
        list.asObservable()
            .subscribe(onNext: {
                self.emptySearchView.isHidden = !$0.isEmpty
            })
            .disposed(by: disposeBag)
    }

    public override func configureViewController() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.estimatedSectionHeaderHeight = 0

        xmarkButton.rx.tap
            .subscribe(onNext: {
                self.searchTextField.text = ""
            })
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        searchTableView.reloadData()
    }

    public override func configureNavigation() {}
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell

        cell.placeTitleLabel.text = "서울 장소장소"
        cell.placeLocationLabel.text = "서울 뭐시기뭐시기 깽깽꺵"

        return cell
    }
}
