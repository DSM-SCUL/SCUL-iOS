import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class MainViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

//    init( ) { }
//    collectionViewCellDidTap
    public struct Input {
        let collectionViewCellDidTap: PublishRelay<Void>
    }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        input.collectionViewCellDidTap.asObservable()
            .map {
                print("여기는 들어오나~")
                return MainStep.placeGuideDetailIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output( )
    }
}
