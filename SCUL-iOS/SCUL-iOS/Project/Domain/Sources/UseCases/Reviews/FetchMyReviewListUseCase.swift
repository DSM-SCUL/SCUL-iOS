import Foundation

import RxSwift

public class FetchMyReviewListUseCase {

    let reviewsRepository: ReviewsRepository
    
    public init(reviewsRepository: ReviewsRepository) {
        self.reviewsRepository = reviewsRepository
    }

    public func execute() -> Single<[MyReviewListEntity]> {
        return reviewsRepository.fetchMyReviewList()
    }
}
