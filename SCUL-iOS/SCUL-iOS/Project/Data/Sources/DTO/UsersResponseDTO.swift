import Foundation

struct UsersResponseDTO: Decodable {
    let accessToken: String
    let accessTokenExp: String
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken
        case accessTokenExp
        case refreshToken
    }
}

extension UsersResponseDTO {
    func toDomain() -> UsersEntity {
        UsersEntity(
            accessToken: accessToken,
            accessTokenExp: accessTokenExp,
            refreshToken: refreshToken
        )
    }
}
