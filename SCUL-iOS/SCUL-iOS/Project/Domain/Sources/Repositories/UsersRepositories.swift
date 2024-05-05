import Foundation

import RxSwift

public protocol UsersRepository {
    func login(req: LoginRequest) -> Single<UsersEntity>
//    func signup(accountId: String, password: String, name: String) -> Completable
}
