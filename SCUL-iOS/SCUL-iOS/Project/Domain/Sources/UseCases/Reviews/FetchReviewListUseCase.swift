import Foundation

import RxSwift

public class FetchReviewListUseCase {

    let reviewsRepository: ReviewsRepository
    
    public init(reviewsRepository: ReviewsRepository) {
        self.reviewsRepository = reviewsRepository
    }

    public func execute(id: String) -> Single<[ReviewListEntity]> {
        return reviewsRepository.fetchReviewList(id: id)
    }
}
