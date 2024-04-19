import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class ViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    public struct Input { }

    public struct Output { }

    public func transform(_ input: Input) -> Output {
        return Output()
    }
}
