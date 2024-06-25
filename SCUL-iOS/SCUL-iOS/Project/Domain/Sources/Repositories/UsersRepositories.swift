import Foundation

import RxSwift

public protocol UsersRepository {
    func login(req: LoginRequest) -> Single<UsersEntity>
    func signup(req: SignupRequest) -> Single<UsersEntity>
    func fetchMyName() -> Single<MyNameEntity>
}
