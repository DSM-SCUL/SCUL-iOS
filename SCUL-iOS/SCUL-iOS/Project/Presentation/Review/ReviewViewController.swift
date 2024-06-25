import UIKit
import SnapKit
import Then

class ReviewViewController: BaseViewController<ReviewViewModel> {
    private let writeReviewLabel = UILabel().then {
        $0.labelSetting(text: "리뷰 작성", font: .sb1)
    }
    private let visitPlaceMenuLabel = UILabel().then {
        $0.labelSetting(text: "방문한 곳", font: .caption1)
        $0.textColor = .Gray400
    }
    private let visitPlaceLabel = UILabel().then {
        $0.labelSetting(text: "서울 시립 미술관", font: .caption1)
    }
    private let contentMenuLabel = UILabel().then {
        $0.labelSetting(text: "내용", font: .label2)
    }
    private let ncPointLabel = UILabel().then {
        $0.labelSetting(text: "*", font: .label2)
        $0.textColor = .Main500
    }
    private let contentTextView = UITextView().then {
        $0.text = "텍스트를 입력하세요"
        $0.layer.cornerRadius = 8
        $0.textColor = .Gray400
        $0.backgroundColor = .Gray50
        $0.textContainerInset = UIEdgeInsets(top: 10.0, left: 9.0, bottom: 10.0, right: 9.0)
    }
    private let pictureMenuLabel = UILabel().then {
        $0.labelSetting(text: "사진", font: .label2)
    }
    private let plusButton = UIButton().then {
        $0.backgroundColor = .Gray50
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
//        $0.image = UIImage(systemName: "plus")
        $0.layer.cornerRadius = 8
        $0.tintColor = .Gray400
    }
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var pictureCollectionView = UICollectionView(
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
            writeReviewLabel,
            visitPlaceMenuLabel,
            visitPlaceLabel,
            contentMenuLabel,
            ncPointLabel,
            contentTextView,
            pictureMenuLabel,
            plusButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        writeReviewLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        visitPlaceMenuLabel.snp.makeConstraints {
            $0.top.equalTo(writeReviewLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        visitPlaceLabel.snp.makeConstraints {
            $0.top.equalTo(writeReviewLabel.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
        contentMenuLabel.snp.makeConstraints {
            $0.top.equalTo(visitPlaceMenuLabel.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(20)
        }
        ncPointLabel.snp.makeConstraints {
            $0.top.equalTo(visitPlaceMenuLabel.snp.bottom).offset(48)
            $0.leading.equalTo(contentMenuLabel.snp.trailing)
        }
        contentTextView.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.top.equalTo(contentMenuLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        pictureMenuLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(20)
        }
        plusButton.snp.makeConstraints {
            $0.top.equalTo(pictureMenuLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(80)
        }
    }

    public override func bind() {}

    public override func configureViewController() {
        contentTextView.delegate = self
    }

    public override func configureNavigation() {}
}

extension ReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let textViewPlaceHolder = "텍스트를 입력하세요"
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let textViewPlaceHolder = "텍스트를 입력하세요"
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .Gray400
        }
    }
}
