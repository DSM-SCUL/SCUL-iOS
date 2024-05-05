import UIKit
import SnapKit
import Then

class MyReviewViewController: BaseViewController<MyReviewViewModel> {
    private let myReviewLabel = UILabel().then {
        $0.labelSetting(text: "내가 작성한 리뷰", font: .sb1)
    }
    private let myReviewTableView = UITableView().then {
        $0.register(
            MyReviewTableViewCell.self,
            forCellReuseIdentifier: MyReviewTableViewCell.identifier
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
            myReviewLabel,
            myReviewTableView
        ].forEach { self.view.addSubview($0) }
    }

    public override func setLayout() {
        myReviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.leading.equalToSuperview().inset(20)
        }

        myReviewTableView.snp.makeConstraints {
            $0.top.equalTo(myReviewLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    public override func bind() {}

    public override func configureViewController() {
        myReviewTableView.dataSource = self
        myReviewTableView.delegate = self
        myReviewTableView.estimatedSectionHeaderHeight = 0
    }

    public override func configureNavigation() {}

    override func viewDidAppear(_ animated: Bool) {
        myReviewTableView.reloadData()
    }
}

extension MyReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyReviewTableViewCell.identifier, for: indexPath) as! MyReviewTableViewCell

        return cell
    }
}
