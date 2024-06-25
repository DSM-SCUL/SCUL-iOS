import Foundation

import RxSwift

public class FetchBookmarkListUseCase {

    let bookmarksRepository: BookmarksRepository
    
    public init(bookmarksRepository: BookmarksRepository) {
        self.bookmarksRepository = bookmarksRepository
    }

    public func execute() -> Single<[BookmarkListEntity]> {
        return bookmarksRepository.fetchBookmarkList()
    }
}
