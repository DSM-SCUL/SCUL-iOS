import RxSwift

protocol RemoteCulturesDataSource {
    func fetchCultureList() -> Single<[CultureListEntity]>
    func fetchCultureDetail(id: String) -> Single<CultureDetailEntity>
    func searchCulture(name: String?) -> Single<[CultureListEntity]>
}

final class RemoteCulturesDataSourceImpl: RemoteBaseDataSource<CulturesAPI>, RemoteCulturesDataSource {
    func fetchCultureList() -> RxSwift.Single<[CultureListEntity]> {
        request(.fetchCultureList)
            .map(FetchCultureListResponseDTO.self)
            .map { $0.toDomain() }
    }

    func fetchCultureDetail(id: String) -> RxSwift.Single<CultureDetailEntity> {
        request(.fetchCultureDetail(id: id))
            .map(FetchCultureDetailResponseDTO.self)
            .map { $0.toDomain() }
    }

    func searchCulture(name: String?) -> RxSwift.Single<[CultureListEntity]> {
        request(.searchCulture(name: name))
            .map(FetchCultureListResponseDTO.self)
            .map { $0.toDomain() }
    }
}
