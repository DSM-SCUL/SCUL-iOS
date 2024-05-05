import RxSwift

struct UsersRepositoryImpl: UsersRepository {
    private let remoteUsersDataSource: any RemoteUsersDataSource

    init(remoteUsersDataSource: any RemoteUsersDataSource) {
        self.remoteUsersDataSource = remoteUsersDataSource
    }

    func login(req: LoginRequest) -> RxSwift.Single<UsersEntity> {
        remoteUsersDataSource.login(req: req)
    }

//    func signup(accountId: String, password: String, name: String) -> RxSwift.Completable {
//        remoteUsersDataSource.
//    }
}
