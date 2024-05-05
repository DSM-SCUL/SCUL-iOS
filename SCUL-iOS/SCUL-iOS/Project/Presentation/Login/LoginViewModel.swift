import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class LoginViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let loginUseCase: LoginUseCase
    
    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    public struct Input {
        let loginButtonDidTap: PublishRelay<(String, String)>
        let navigateToSignupButtonDidTap: PublishRelay<Void>
        let idText: Observable<String>
        let passwordText: Observable<String>
        let loginButtonSignal: Observable<Void>
    }

    public struct Output {
        
    }

    public func transform(_ input: Input) -> Output {
        let usersEntity = PublishRelay<UsersEntity>()

        input.loginButtonDidTap
            .flatMap { id, pw in
                self.loginUseCase.execute(req:
                                            LoginRequest(
                                                accountId: id,
                                                password: pw
                                            ))
            }
            .bind(to: usersEntity)
            .disposed(by: disposeBag)

        input.navigateToSignupButtonDidTap.asObservable()
            .map {
                LoginStep.signupIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
