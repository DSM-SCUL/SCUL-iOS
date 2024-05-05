import Foundation

public struct LoginRequest: Encodable {
    public let accountId: String
    public let password: String

    public init(
        accountId: String,
        password: String
    ) {
        self.accountId = accountId
        self.password = password
    }

    enum CodingKeys: String, CodingKey {
        case accountId, password
    }
}
