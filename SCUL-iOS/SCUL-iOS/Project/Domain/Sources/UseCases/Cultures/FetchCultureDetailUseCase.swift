import Foundation

import RxSwift

public class FetchCultureDetailUseCase {

    let culturesRepository: CulturesRepository
    
    public init(culturesRepository: CulturesRepository) {
        self.culturesRepository = culturesRepository
    }

    public func execute(id: String) -> Single<CultureDetailEntity> {
        return culturesRepository.fetchCultureDetail(id: id)
    }
}
