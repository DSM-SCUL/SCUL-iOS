import Foundation

import RxSwift

public class BookmarkUseCase {

    let bookmarksRepository: BookmarksRepository
    
    public init(bookmarksRepository: BookmarksRepository) {
        self.bookmarksRepository = bookmarksRepository
    }

    public func execute(id: String) -> RxSwift.Completable {
        return bookmarksRepository.bookmark(id: id)
    }
}
