import RxSwift

protocol RemoteUsersDataSource {
    func login(req: LoginRequest) -> Single<UsersEntity>
}

final class RemoteUsersDataSourceImpl: RemoteBaseDataSource<UsersAPI>, RemoteUsersDataSource {
    func login(req: LoginRequest) -> Single<UsersEntity> {
        request(.login(req))
            .map(UsersResponseDTO.self)
            .map { $0.toDomain() }
    }
}
