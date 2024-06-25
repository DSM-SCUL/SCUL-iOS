import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class BookmarkViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchBookmarkListUseCase: FetchBookmarkListUseCase
    private let bookmarkUseCase: BookmarkUseCase
    
    public init(
        fetchBookmarkListUseCase: FetchBookmarkListUseCase,
        bookmarkUseCase: BookmarkUseCase
    ) {
        self.fetchBookmarkListUseCase = fetchBookmarkListUseCase
        self.bookmarkUseCase = bookmarkUseCase
    }

    public struct Input {
        let viewAppear: PublishRelay<Void>
        let bookmarkButtonDidTap: PublishRelay<String>
    }

    public struct Output {
        var bookmarkListData = PublishRelay<[BookmarkListEntity]>()
    }

    public var bookmarkListData = PublishRelay<[BookmarkListEntity]>()

    public func transform(_ input: Input) -> Output {
        input.viewAppear.asObservable()
            .flatMap {
                self.fetchBookmarkListUseCase.execute()
            }
            .bind(to: bookmarkListData)
            .disposed(by: disposeBag)

        input.bookmarkButtonDidTap.asObservable()
            .flatMap { id in
                self.bookmarkUseCase.execute(id: id)
            }
            .subscribe()
            .disposed(by: disposeBag)

        return Output(bookmarkListData: bookmarkListData)
    }
}
