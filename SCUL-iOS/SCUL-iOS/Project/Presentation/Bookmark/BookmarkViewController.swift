import UIKit
import SnapKit
import Then

class BookmarkViewController: BaseViewController<BookmarkViewModel> {
    private let bookmarkLabel = UILabel().then {
        $0.labelSetting(text: "북마크", font: .sb1)
        $0.textColor = .black
    }
    private let bookmarkTableView = UITableView().then {
        $0.register(
            SearchTableViewCell.self,
            forCellReuseIdentifier: SearchTableViewCell.identifier
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

    public override func bind() {}

    public override func configureViewController() {
        bookmarkTableView.dataSource = self
        bookmarkTableView.delegate = self
        bookmarkTableView.estimatedSectionHeaderHeight = 0
    }

    public override func configureNavigation() {}

    override func viewDidAppear(_ animated: Bool) {
        bookmarkTableView.reloadData()
    }
}

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell

        return cell
    }
}
