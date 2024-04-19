import UIKit
import RxCocoa
import RxSwift

public class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
    public let viewModel: ViewModel
    public var disposeBag = DisposeBag()
    public var viewDidLoadPublisher = PublishRelay<Void>()
    public var viewWillAppearPublisher = PublishRelay<Void>()
    public var viewDidAppearPublisher = PublishRelay<Void>()
    public var viewWillDisappearPublisher = PublishRelay<Void>()
    public var viewDidDisappearPublisher = PublishRelay<Void>()

    public init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addView()
        setLayout()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configureViewController()
        configureNavigation()

        self.viewDidLoadPublisher.accept(())
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearPublisher.accept(())
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppearPublisher.accept(())
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewWillDisappearPublisher.accept(())
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewDidDisappearPublisher.accept(())
    }

    public func addView() {}

    public func setLayout() {}

    public func bind() {}

    public func configureViewController() {}

    public func configureNavigation() {}
}
