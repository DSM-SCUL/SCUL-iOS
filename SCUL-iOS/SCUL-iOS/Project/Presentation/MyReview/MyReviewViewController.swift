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

    public override func bind() {
        let input = MyReviewViewModel.Input(
            viewAppear: self.viewDidLoadPublisher
        )

        let output = viewModel.transform(input)

        output.myReviewData
            .bind(
                to: myReviewTableView.rx.items(
                    cellIdentifier: MyReviewTableViewCell.identifier,
                    cellType: MyReviewTableViewCell.self
                )) { _, element, cell in
                    cell.adapt(model: element)
                }
                .disposed(by: disposeBag)
    }

    public override func configureViewController() {
        myReviewTableView.estimatedSectionHeaderHeight = 0
    }

    public override func configureNavigation() {}
}
