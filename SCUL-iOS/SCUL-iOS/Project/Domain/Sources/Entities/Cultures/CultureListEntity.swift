import Foundation

public struct CultureListEntity: Equatable, Hashable {
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

//Content-Type: application/json
//
//{
//    "culture": [
//        {
//            "id": "0647a919-33cb-44ee-9cc4-6f20d74f9258",
//            "location": "중구",
//            "placeName": "남산골한옥마을",
//            "ticketPrice": "무료",
//            "isBookMarked": false,
//            "imageUrl": "https://yeyak.seoul.go.kr/web/common/file/FileDown.do?file_id=1677122430675N88CFYM6Y1NUKXFRNWWUL52Y0",
//            "cultureName": "2024년 미니장승만들기(매주 토 10:30~12:30)",
//            "wantedPeople": "유아(만5세이상), 초등학생"
//            "isApplicationAble": true
//        }
//    ]
//}
