import RxSwift

struct BookmarksRepositoryImpl: BookmarksRepository {
    private let remoteBookmarksDataSource: any RemoteBookmarksDataSource

    init(remoteBookmarksDataSource: any RemoteBookmarksDataSource) {
        self.remoteBookmarksDataSource = remoteBookmarksDataSource
    }

    func fetchBookmarkList() -> RxSwift.Single<[BookmarkListEntity]> {
        return remoteBookmarksDataSource.fetchBookmarkList()
    }
    
    func bookmark(id: String) -> RxSwift.Completable {
        return remoteBookmarksDataSource.bookmark(id: id)
    }
}
