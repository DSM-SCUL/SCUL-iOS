import Foundation

struct UsersResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }
}

extension UsersResponseDTO {
    func toDomain() -> UsersEntity {
        UsersEntity(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
