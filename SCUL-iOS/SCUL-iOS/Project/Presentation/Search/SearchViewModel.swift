import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class SearchViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

//    init( ) { }

    public struct Input {
        let tableViewCellDidTap: PublishRelay<Void>
    }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        input.tableViewCellDidTap.asObservable()
            .map {
                print("여기는 들어오나~")
                return SearchStep.placeGuideDetailIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output( )
    }
}
