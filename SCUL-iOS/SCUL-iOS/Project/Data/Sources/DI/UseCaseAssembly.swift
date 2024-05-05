import Foundation
import Swinject

public final class UseCaseAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        // Users
        container.register(LoginUseCase.self) { resolver in
            LoginUseCase(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
//        container.register(LogoutUseCase.self) { resolver in
//            LogoutUseCase(
//                usersRepository: resolver.resolve(UsersRepository.self)!
//            )
//        }
    }
}
