import Foundation

struct FetchMyReviewListResponseDTO: Decodable {
    let reviewList: [FetchMyReviewResponseDTO]
}

struct FetchMyReviewResponseDTO: Decodable {
    let id: String
    let writer: String
    let content: String
    let createdAt: String
    let imageUrls: [String]
    let placeName: String

    enum CodingKeys: String, CodingKey {
        case id, writer, content, createdAt, imageUrls, placeName
    }
}

extension FetchMyReviewListResponseDTO {
    func toDomain() -> [MyReviewListEntity] {
        reviewList.map {
            MyReviewListEntity(
                id: $0.id,
                writer: $0.writer,
                content: $0.content,
                createdAt: $0.createdAt,
                imageUrls: $0.imageUrls,
                placeName: $0.placeName
            )
        }
    }
}

//reviewList": [
//{
//    "id": "08d8b1a2-ec89-4dcc-b619-bd7cbee8d3c5",
//    "writer": "dfddwqm",
//    "content": "das",
//    "createdAt": "2024-05-06",
//    "imageUrls": [
//        "https://kangsunbucket.s3.ap-northeast-2.amazonaws.com/59827f51-25d1-4683-8035-215d6bcf3108_DMS%20SYMBOL.png"
//    ],
//    "placeName": "도서관 아니면 박물관"
//},
