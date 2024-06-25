import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class MainViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchCultureListUseCase: FetchCultureListUseCase
    private let bookmarkUseCase: BookmarkUseCase

    public init(
        fetchCultureListUseCase: FetchCultureListUseCase,
        bookmarkUseCase: BookmarkUseCase
    ) {
        self.fetchCultureListUseCase = fetchCultureListUseCase
        self.bookmarkUseCase = bookmarkUseCase
    }

    public struct Input {
        let viewAppear: PublishRelay<Void>
        let bookmarkButtonDidTap: PublishRelay<String>
        let collectionViewCellDidTap: PublishRelay<String>
    }

    public struct Output {
        var cultureListData = PublishRelay<[CultureListEntity]>()
    }

    public var cultureListData = PublishRelay<[CultureListEntity]>()

    public func transform(_ input: Input) -> Output {
        input.viewAppear.asObservable()
            .flatMap {
                self.fetchCultureListUseCase.execute()
            }
            .bind(to: cultureListData)
            .disposed(by: disposeBag)

        input.bookmarkButtonDidTap.asObservable()
            .flatMap { id in
                self.bookmarkUseCase.execute(id: id)
            }
            .subscribe()
            .disposed(by: disposeBag)

        input.collectionViewCellDidTap.asObservable()
            .map { id in
                return MainStep.placeGuideDetailIsRequired(
                    cultureDetailId: id
                )
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(cultureListData: cultureListData)
    }
}

//Thread 1: Fatal error: Binding error to behavior relay: objectMapping(Swift.DecodingError.keyNotFound(CodingKeys(stringValue: "cultureList", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"cultureList\", intValue: nil) (\"cultureList\").", underlyingError: nil)), Status Code: 200, Data Length: 261524)
