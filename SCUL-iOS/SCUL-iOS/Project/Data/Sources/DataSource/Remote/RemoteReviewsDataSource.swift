import RxSwift

protocol RemoteReviewsDataSource {
    func fetchReviewList(id: String) -> Single<[ReviewListEntity]>
    func fetchMyReviewList() -> Single<[MyReviewListEntity]>
}

final class RemoteReviewsDataSourceImpl: RemoteBaseDataSource<ReviewsAPI>, RemoteReviewsDataSource {
    func fetchReviewList(id: String) -> RxSwift.Single<[ReviewListEntity]> {
        request(.fetchReviewList(id: id))
            .map(FetchReviewListResponseDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchMyReviewList() -> RxSwift.Single<[MyReviewListEntity]> {
        request(.fetchMyReviewList)
            .map(FetchMyReviewListResponseDTO.self)
            .map { $0.toDomain() }
    }
    
//    func bookmark(id: String) -> RxSwift.Completable {
//        request(.bookmark(id: id))
//            .asCompletable()
//    }
//
//    func fetchBookmarkList() -> RxSwift.Single<[BookmarkListEntity]> {
//        request(.fetchBookmarkList)
//            .map(FetchBookmarkListResponseDTO.self)
//            .map { $0.toDomain() }
//    }
}
