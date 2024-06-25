import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class SearchViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchCultureListUseCase: FetchCultureListUseCase
    private let bookmarkUseCase: BookmarkUseCase
    private let searchCulture: SearchCultureUseCase
    

    public init(
        fetchCultureListUseCase: FetchCultureListUseCase,
        bookmarkUseCase: BookmarkUseCase,
        searchCulture: SearchCultureUseCase
    ) {
        self.fetchCultureListUseCase = fetchCultureListUseCase
        self.bookmarkUseCase = bookmarkUseCase
        self.searchCulture = searchCulture
    }

    public struct Input {
        let viewAppear: PublishRelay<Void>
        let bookmarkButtonDidTap: PublishRelay<String>
        let tableViewCellDidTap: PublishRelay<String>
        let searchButtonDidTap: PublishRelay<String>
    }

    public struct Output {
        var cultureListData = PublishRelay<[CultureListEntity]>()
        let emptyViewIsHidden: PublishRelay<Bool>
    }

    public var cultureListData = PublishRelay<[CultureListEntity]>()

    public func transform(_ input: Input) -> Output {
        let emptyViewIsHidden = PublishRelay<Bool>()

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

        input.tableViewCellDidTap.asObservable()
            .map { id in
                return SearchStep.placeGuideDetailIsRequired(
                    cultureDetailId: id
                )
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.searchButtonDidTap.asObservable()
            .filter {
                emptyViewIsHidden.accept(!$0.isEmpty)
                return $0 != ""
            }
            .flatMap {
                return self.searchCulture.execute(name: $0)
            }
            .bind(to: cultureListData)
            .disposed(by: disposeBag)

        return Output(
            cultureListData: cultureListData,
            emptyViewIsHidden: emptyViewIsHidden
        )
    }
}
