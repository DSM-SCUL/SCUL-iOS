import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class MyReviewViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchMyReviewListUseCase: FetchMyReviewListUseCase

    public init(
        fetchMyReviewListUseCase: FetchMyReviewListUseCase
    ) {
        self.fetchMyReviewListUseCase = fetchMyReviewListUseCase
    }

    public struct Input {
        let viewAppear: PublishRelay<Void>
    }

    public struct Output {
        var myReviewData = PublishRelay<[MyReviewListEntity]>()
    }

    public var myReviewData = PublishRelay<[MyReviewListEntity]>()

    public func transform(_ input: Input) -> Output {
        input.viewAppear.asObservable()
            .flatMap {
                self.fetchMyReviewListUseCase.execute()
            }
            .bind(to: myReviewData)
            .disposed(by: disposeBag)

        return Output(myReviewData: myReviewData)
    }
}
