import RxSwift

struct ReviewsRepositoryImpl: ReviewsRepository {
    private let remoteReviewsDataSource: any RemoteReviewsDataSource

    init(remoteReviewsDataSource: any RemoteReviewsDataSource) {
        self.remoteReviewsDataSource = remoteReviewsDataSource
    }

    func fetchMyReviewList() -> RxSwift.Single<[MyReviewListEntity]> {
        return remoteReviewsDataSource.fetchMyReviewList()
    }
    
    func fetchReviewList(id: String) -> RxSwift.Single<[ReviewListEntity]> {
        return remoteReviewsDataSource.fetchReviewList(id: id)
    }
}
