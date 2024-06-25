import Foundation

import RxSwift

public protocol CulturesRepository {
    func fetchCultureList() -> Single<[CultureListEntity]>
    func fetchCultureDetail(id: String) -> Single<CultureDetailEntity>
    func searchCulture(name: String?) -> Single<[CultureListEntity]>
}
