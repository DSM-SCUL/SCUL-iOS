import Foundation

import RxSwift

public class FetchCultureListUseCase {

    let culturesRepository: CulturesRepository
    
    public init(culturesRepository: CulturesRepository) {
        self.culturesRepository = culturesRepository
    }

    public func execute() -> Single<[CultureListEntity]> {
        return culturesRepository.fetchCultureList()
    }
}
