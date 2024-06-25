import UIKit
import RxSwift
import RxCocoa
import RxFlow

public final class PlaceGuideDetailViewModel: BaseViewModel, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    public var cultureDetailId: String?
    private let fetchCultureDetailUseCase: FetchCultureDetailUseCase
    private let fetchReviewListUseCase: FetchReviewListUseCase
    private let bookmarkUseCase: BookmarkUseCase

    public init(
        fetchCultureDetailUseCase: FetchCultureDetailUseCase,
        fetchReviewListUseCase: FetchReviewListUseCase,
        bookmarkUseCase: BookmarkUseCase
    ) {
        self.fetchCultureDetailUseCase = fetchCultureDetailUseCase
        self.fetchReviewListUseCase = fetchReviewListUseCase
        self.bookmarkUseCase = bookmarkUseCase
    }

    public struct Input {
        let viewAppear: PublishRelay<Void>
        let bookmarkButtonDidTap: PublishRelay<String>
        let navigateToReviewButtonDidClicked: PublishRelay<Void>
    }

    public struct Output {
        var cultureDetailData = PublishRelay<CultureDetailEntity>()
        var reviewData = PublishRelay<[ReviewListEntity]>()
    }

    public var cultureDetailData = PublishRelay<CultureDetailEntity>()
    public var reviewData = PublishRelay<[ReviewListEntity]>()

    public func transform(_ input: Input) -> Output {
        input.viewAppear.asObservable()
            .flatMap {
                self.fetchCultureDetailUseCase.execute(id: self.cultureDetailId ?? "")
            }
            .bind(to: cultureDetailData)
            .disposed(by: disposeBag)

        input.viewAppear.asObservable()
            .flatMap {
                self.fetchReviewListUseCase.execute(id: self.cultureDetailId ?? "")
            }
            .bind(to: reviewData)
            .disposed(by: disposeBag)

        input.bookmarkButtonDidTap.asObservable()
            .flatMap { id in
                self.bookmarkUseCase.execute(id: id)
            }
            .subscribe()
            .disposed(by: disposeBag)

        input.navigateToReviewButtonDidClicked.asObservable()
            .map {
                PlaceGuideDetailStep.reviewIsRequired
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            cultureDetailData: cultureDetailData,
            reviewData: reviewData
        )
    }
}
