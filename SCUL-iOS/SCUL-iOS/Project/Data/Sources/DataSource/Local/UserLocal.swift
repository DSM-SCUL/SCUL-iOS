import RxSwift

protocol LocalUsersDataSource {
    func clearTokens()
}

public struct LocalUsersDataSourceImpl: LocalUsersDataSource {
    private let keychain: any Keychain

    public init(keychain: any Keychain) {
        self.keychain = keychain
    }

    public func clearTokens() {
        keychain.delete(type: .accessToken)
        keychain.delete(type: .refreshToken)
    }
}
