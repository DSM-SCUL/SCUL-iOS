import Foundation

struct FetchBookmarkListResponseDTO: Decodable {
    let culture: [FetchBookmarkResponseDTO]
}

struct FetchBookmarkResponseDTO: Decodable {
    let id: String
    let location: String
    let placeName: String
    let ticketPrice: String
    let isBookMarked: Bool
    let imageUrl: String
    let cultureName: String
    let wantedPeople: String
    let isApplicationAble: Bool

    enum CodingKeys: String, CodingKey {
        case id, location, placeName, ticketPrice, isBookMarked, imageUrl, cultureName, wantedPeople, isApplicationAble
    }
}

extension FetchBookmarkListResponseDTO {
    func toDomain() -> [BookmarkListEntity] {
        culture.map {
            BookmarkListEntity(
                id: $0.id,
                location: $0.location,
                placeName: $0.placeName,
                ticketPrice: $0.ticketPrice,
                isBookMarked: $0.isBookMarked,
                imageUrl: $0.imageUrl,
                cultureName: $0.cultureName,
                wantedPeople: $0.wantedPeople,
                isApplicationAble: $0.isApplicationAble
            )
        }
    }
}
