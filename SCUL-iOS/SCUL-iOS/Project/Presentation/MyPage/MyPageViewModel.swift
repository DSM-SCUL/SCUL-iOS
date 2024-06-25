import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class MyPageViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchMyNameUseCase: FetchMyNameUseCase
    
    public init(fetchMyNameUseCase: FetchMyNameUseCase) {
        self.fetchMyNameUseCase = fetchMyNameUseCase
    }

    public struct Input {
        let viewAppear: PublishRelay<Void>
        let myReviewButtonDidTap: PublishRelay<Void>
        let bookmarkButtonDidTap: PublishRelay<Void>
        let logoutButtonDidTap: PublishRelay<Void>
    }

    public struct Output {
//        let myName: PublishRelay<MyNameEntity>
        let myName: Signal<MyNameEntity>
    }

    let myName = PublishRelay<MyNameEntity>()

    public func transform(_ input: Input) -> Output {
        input.viewAppear.asObservable()
            .flatMap {
                return self.fetchMyNameUseCase.execute()
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: myName)
            .disposed(by: disposeBag)

        input.myReviewButtonDidTap.asObservable()
            .map {
                print("여기는 들어오나~")
                return MyPageStep.myReviewIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.bookmarkButtonDidTap.asObservable()
            .map {
                print("여기는 들어오나~")
                return MyPageStep.bookmarkIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.logoutButtonDidTap.asObservable()
            .map {
                print("여기는 들어오나~")
                return MyPageStep.tabsIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(myName: myName.asSignal())
    }
}
