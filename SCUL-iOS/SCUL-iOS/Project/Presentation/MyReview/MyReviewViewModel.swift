import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class MyReviewViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

//    init( ) { }

    public struct Input { }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        return Output( )
    }
}
