import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class OnboardingViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    init( ) { }

    public struct Input {
        let navigateToLoginButtonDidTap: PublishRelay<Void>
    }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        input.navigateToLoginButtonDidTap.asObservable()
            .map {
                OnboardingStep.loginIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output( )
    }
}
