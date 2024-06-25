import Foundation

struct FetchReviewListResponseDTO: Decodable {
    let reviewList: [FetchReviewResponseDTO]
}

struct FetchReviewResponseDTO: Decodable {
    let id: String
    let writer: String
    let content: String
    let createdAt: String
    let imageUrls: [String]

    enum CodingKeys: String, CodingKey {
        case id, writer, content, createdAt, imageUrls
    }
}

extension FetchReviewListResponseDTO {
    func toDomain() -> [ReviewListEntity] {
        reviewList.map {
            ReviewListEntity(
                id: $0.id,
                writer: $0.writer,
                content: $0.content,
                createdAt: $0.createdAt,
                imageUrls: $0.imageUrls
            )
        }
    }
}
