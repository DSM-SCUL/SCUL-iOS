import RxSwift

struct CulturesRepositoryImpl: CulturesRepository {
    private let remoteCulturesDataSource: any RemoteCulturesDataSource

    init(remoteCulturesDataSource: any RemoteCulturesDataSource) {
        self.remoteCulturesDataSource = remoteCulturesDataSource
    }

    func fetchCultureList() -> RxSwift.Single<[CultureListEntity]> {
        remoteCulturesDataSource.fetchCultureList()
    }

    func fetchCultureDetail(id: String) -> RxSwift.Single<CultureDetailEntity> {
        remoteCulturesDataSource.fetchCultureDetail(id: id)
    }

    func searchCulture(name: String?) -> Single<[CultureListEntity]> {
        remoteCulturesDataSource.searchCulture(name: name)
    }
}
