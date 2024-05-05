import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class MyPageViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

//    init( ) { }

    public struct Input {
        let myReviewButtonDidTap: PublishRelay<Void>
    }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        input.myReviewButtonDidTap.asObservable()
            .map {
                print("여기는 들어오나~")
                return MyPageStep.myReviewIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output( )
    }
}
