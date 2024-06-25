import Foundation

import RxSwift

public protocol BookmarksRepository {
    func fetchBookmarkList() -> Single<[BookmarkListEntity]>
    func bookmark(id: String) -> RxSwift.Completable
}
