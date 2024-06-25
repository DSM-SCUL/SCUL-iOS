import Foundation

public struct CultureDetailEntity: Equatable, Hashable {
    public let id: String
    public let location: String
    public let placeName: String
    public let ticketPrice: String
    public let isBookMarked: Bool
    public let imageUrl: String
    public let cultureName: String
    public let wantedPeople: String
    public let content: String
    public let phoneNumber: String
    public let isApplicationAble: Bool
    public let applicationStartDate: String
    public let applicationEndDate: String
    public let serviceStartDate: String
    public let serviceEndDate: String
    public let serviceStartTime: String
    public let serviceEndTime: String
    public let cultureLink: String
    public let ycoordinate: Float
    public let xcoordinate: Float

    public init(
        id: String,
        location: String,
        placeName: String,
        ticketPrice: String,
        isBookMarked: Bool,
        imageUrl: String,
        cultureName: String,
        wantedPeople: String,
        content: String,
        phoneNumber: String,
        isApplicationAble: Bool,
        applicationStartDate: String,
        applicationEndDate: String,
        serviceStartDate: String,
        serviceEndDate: String,
        serviceStartTime: String,
        serviceEndTime: String,
        cultureLink: String,
        ycoordinate: Float,
        xcoordinate: Float
    ) {
        self.id = id
        self.location = location
        self.placeName = placeName
        self.ticketPrice = ticketPrice
        self.isBookMarked = isBookMarked
        self.imageUrl = imageUrl
        self.cultureName = cultureName
        self.wantedPeople = wantedPeople
        self.content = content
        self.phoneNumber = phoneNumber
        self.isApplicationAble = isApplicationAble
        self.applicationStartDate = applicationStartDate
        self.applicationEndDate = applicationEndDate
        self.serviceStartDate = serviceStartDate
        self.serviceEndDate = serviceEndDate
        self.serviceStartTime = serviceStartTime
        self.serviceEndTime = serviceEndTime
        self.cultureLink = cultureLink
        self.ycoordinate = ycoordinate
        self.xcoordinate = xcoordinate
    }
}
