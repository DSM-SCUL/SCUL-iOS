import Foundation

import RxSwift

public class FetchMyNameUseCase {

    let usersRepository: UsersRepository
    
    public init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }

    public func execute() -> Single<MyNameEntity> {
        return usersRepository.fetchMyName()
    }
}
