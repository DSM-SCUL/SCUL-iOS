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
        let errorDescription: Signal<String?>
    }

    private let errorDescription = PublishRelay<String?>()

    public func transform(_ input: Input) -> Output {
        let loginSuccess = PublishRelay<Void>()

        input.loginButtonDidTap
            .flatMap { id, pw in
                self.loginUseCase.execute(req:
                                            LoginRequest(
                                                accountId: id,
                                                password: pw
                                            ))
                .map { _ in
                    return true // 로그인 성공 시 true를 방출
                }
                .catchAndReturn(false) // 에러가 발생하면 false를 방출
            }
            .subscribe(onNext: { isSuccess in
                if isSuccess {
                    loginSuccess.accept(()) // 성공한 경우에만 성공 이벤트를 방출
                } else {
                    self.errorDescription.accept("다시 확인해주세요")
                }
            }, onError: { error in
                self.errorDescription.accept("다시 확인해주세요")
                print("Login error: \(error)")
            })
            .disposed(by: disposeBag)
//            .subscribe(onNext: { _ in
//                    loginSuccess.accept(())
//                }, onError: { error in
//                    self.errorDescription.accept("다시 확인해주세요")
//                    print("Login error: \(error)")
//                })
//            .disposed(by: disposeBag)

        loginSuccess.map {
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

        return Output(errorDescription: errorDescription.asSignal())
    }
}
