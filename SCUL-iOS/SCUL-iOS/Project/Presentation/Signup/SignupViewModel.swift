import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class SignupViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let signupUseCase: SignupUseCase
    
    public init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }

    public struct Input {
        let signupButtonDidTap: PublishRelay<(String, String, String)>
    }

    public struct Output {
        var signupSuccess = PublishRelay<Void>()
        let errorDescription: Signal<String?>
    }

    private let errorDescription = PublishRelay<String?>()

    public func transform(_ input: Input) -> Output {
        var signupSuccess = PublishRelay<Void>()

        input.signupButtonDidTap
            .flatMap { id, pw, name in
                print("signupButton viewModel!")
                return self.signupUseCase.execute(req: SignupRequest(
                    accountId: id,
                    password: pw,
                    name: name
                )).map { _ in
                    return true
                }
                .catchAndReturn(false)
            }
            .subscribe(onNext: { isSuccess in
                if isSuccess {
                    signupSuccess.accept(()) // 성공한 경우에만 성공 이벤트를 방출
                } else {
                    self.errorDescription.accept("이미 있는 아이디입니다.")
                }
            }, onError: { error in
                print(error)
                self.errorDescription.accept("이미 있는 아이디입니다.")
            })
            .disposed(by: disposeBag)

        signupSuccess.map {
            print("signupButton navigate!")
            return SignupStep.tabsIsRequired
        }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            signupSuccess: signupSuccess,
            errorDescription: errorDescription.asSignal()
        )
    }
}
