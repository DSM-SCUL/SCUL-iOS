import Foundation

public struct UsersEntity: Equatable, Hashable {
    public let accessToken: String
    public let accessTokenExp: String
    public let refreshToken: String

    public init(
        accessToken: String,
        accessTokenExp: String,
        refreshToken: String
    ) {
        self.accessToken = accessToken
        self.accessTokenExp = accessTokenExp
        self.refreshToken = refreshToken
    }
}
