import Foundation

public struct TokenDTO: Equatable, Decodable {
    let accessToken: String
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken, refreshToken
    }
}

extension TokenDTO {
    func toDomain() -> UsersEntity {
        UsersEntity(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
