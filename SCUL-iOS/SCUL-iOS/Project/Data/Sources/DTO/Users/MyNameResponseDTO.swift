import Foundation

struct MyNameResponseDTO: Decodable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

extension MyNameResponseDTO {
    func toDomain() -> MyNameEntity {
        MyNameEntity(
            name: name
        )
    }
}
