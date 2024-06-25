import Foundation

import RxSwift

public protocol ReviewsRepository {
    func fetchMyReviewList() -> Single<[MyReviewListEntity]>
    func fetchReviewList(id: String) -> Single<[ReviewListEntity]>
}
