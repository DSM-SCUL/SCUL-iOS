import RxSwift

protocol RemoteUsersDataSource {
    func login(req: LoginRequest) -> Single<UsersEntity>
    func signup(req: SignupRequest) -> Single<UsersEntity>
    func fetchMyName() -> Single<MyNameEntity>
}

final class RemoteUsersDataSourceImpl: RemoteBaseDataSource<UsersAPI>, RemoteUsersDataSource {
    func login(req: LoginRequest) -> Single<UsersEntity> {
        request(.login(req))
            .map(TokenDTO.self)
            .map { $0.toDomain() }
    }

    func signup(req: SignupRequest) -> RxSwift.Single<UsersEntity> {
        request(.signup(req))
            .map(TokenDTO.self)
            .map { $0.toDomain() }
    }

    func fetchMyName() -> Single<MyNameEntity> {
        request(.fetchMyName)
            .map(MyNameResponseDTO.self)
            .map { $0.toDomain() }
    }
}
