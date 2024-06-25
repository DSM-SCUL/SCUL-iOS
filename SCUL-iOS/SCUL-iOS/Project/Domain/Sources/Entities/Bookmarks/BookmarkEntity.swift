import Foundation

public struct BookmarkListEntity: Equatable, Hashable {
    public let id: String
    public let location: String
    public let placeName: String
    public let ticketPrice: String
    public let isBookMarked: Bool
    public let imageUrl: String
    public let cultureName: String
    public let wantedPeople: String
    public let isApplicationAble: Bool

    public init(
        id: String,
        location: String,
        placeName: String,
        ticketPrice: String,
        isBookMarked: Bool,
        imageUrl: String,
        cultureName: String,
        wantedPeople: String,
        isApplicationAble: Bool
    ) {
        self.id = id
        self.location = location
        self.placeName = placeName
        self.ticketPrice = ticketPrice
        self.isBookMarked = isBookMarked
        self.imageUrl = imageUrl
        self.cultureName = cultureName
        self.wantedPeople = wantedPeople
        self.isApplicationAble = isApplicationAble
    }
}
