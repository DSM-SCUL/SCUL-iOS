import Foundation
import RxSwift

public class LoginUseCase {

    let usersRepository: UsersRepository
    
    public init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }

    public func execute(req: LoginRequest) -> Single<UsersEntity> {
        usersRepository.login(req: req)
    }
}
