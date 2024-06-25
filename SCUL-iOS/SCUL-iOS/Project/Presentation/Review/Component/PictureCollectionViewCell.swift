import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class PictureCollectionViewCell: BaseCollectionViewCell<CultureListEntity> {
    static let identifier = "CollectionViewCustomCell"
    private let disposeBag = DisposeBag()

    private let containerView = UIView().then {
        $0.backgroundColor = .Gray50
        $0.layer.cornerRadius = 8
    }
    private let placeImage = UIImageView().then {
        $0.backgroundColor = .Gray200
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func addView() {
        contentView.addSubview(containerView)
        [

        ].forEach { containerView.addSubview($0) }
    }

    public override func setLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width).priority(999)
        }
        
    }

    public override func configureView() {
        
    }

//    public override func adapt(model: CultureListEntity) {
//        super.adapt(model: model)
//    }
}

//extension UIImageView {
//    func loadImage(from url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
//            }
//        }
//    }
//}
