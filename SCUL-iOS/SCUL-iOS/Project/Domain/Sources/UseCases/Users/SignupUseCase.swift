import Foundation

import RxSwift

public class SignupUseCase {

    let usersRepository: UsersRepository
    
    public init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }

    public func execute(req: SignupRequest) -> Single<UsersEntity> {
        return usersRepository.signup(req: req)
    }
}
