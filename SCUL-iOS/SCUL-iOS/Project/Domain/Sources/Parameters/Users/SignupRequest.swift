import Foundation

public struct SignupRequest: Encodable {
    public let accountId: String
    public let password: String
    public let name: String

    public init(
        accountId: String,
        password: String,
        name: String
    ) {
        self.accountId = accountId
        self.password = password
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case accountId, password, name
    }
}

//{
//    "accountId" : "aasssdf1g",
//    "password" : "addfasddd",
//    "name" : "dfsdda"
//}
