import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class LoginViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

//    init( ) { }

    public struct Input {
        let navigateToMainButtonDidTap: PublishRelay<Void>
        let navigateToSignupButtonDidTap: PublishRelay<Void>
    }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        input.navigateToMainButtonDidTap.asObservable()
            .map {
                print("This is ViewModel2")
                return LoginStep.tabsIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.navigateToSignupButtonDidTap.asObservable()
            .map {
                LoginStep.signupIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output( )
    }
}
