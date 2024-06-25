import Foundation

public struct MyReviewListEntity: Equatable, Hashable {
    public let id: String
    public let writer: String
    public let content: String
    public let createdAt: String
    public let imageUrls: [String]
    public let placeName: String

    public init(
        id: String,
        writer: String,
        content: String,
        createdAt: String,
        imageUrls: [String],
        placeName: String
    ) {
        self.id = id
        self.writer = writer
        self.content = content
        self.createdAt = createdAt
        self.imageUrls = imageUrls
        self.placeName = placeName
    }
}
