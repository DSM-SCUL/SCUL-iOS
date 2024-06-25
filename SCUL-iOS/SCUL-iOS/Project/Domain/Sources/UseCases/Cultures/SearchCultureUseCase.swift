import Foundation

import RxSwift

public class SearchCultureUseCase {

    let culturesRepository: CulturesRepository
    
    public init(culturesRepository: CulturesRepository) {
        self.culturesRepository = culturesRepository
    }

    public func execute(name: String?) -> Single<[CultureListEntity]> {
        culturesRepository.searchCulture(name: name ?? "")
    }
}
