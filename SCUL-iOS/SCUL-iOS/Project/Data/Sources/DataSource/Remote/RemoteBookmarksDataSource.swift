import RxSwift

protocol RemoteBookmarksDataSource {
    func bookmark(id: String) -> Completable
    func fetchBookmarkList() -> Single<[BookmarkListEntity]>
}

final class RemoteBookmarksDataSourceImpl: RemoteBaseDataSource<BookmarksAPI>, RemoteBookmarksDataSource {
    func bookmark(id: String) -> RxSwift.Completable {
        request(.bookmark(id: id))
            .asCompletable()
    }

    func fetchBookmarkList() -> RxSwift.Single<[BookmarkListEntity]> {
        request(.fetchBookmarkList)
            .map(FetchBookmarkListResponseDTO.self)
            .map { $0.toDomain() }
    }
}
