import Foundation

struct FetchCultureDetailResponseDTO: Decodable {
    let id: String
    let location: String
    let placeName: String
    let ticketPrice: String
    let isBookMarked: Bool
    let imageUrl: String
    let cultureName: String
    let wantedPeople: String
    let content: String
    let phoneNumber: String
    let isApplicationAble: Bool
    let applicationStartDate: String
    let applicationEndDate: String
    let serviceStartDate: String
    let serviceEndDate: String
    let serviceStartTime: String
    let serviceEndTime: String
    let cultureLink: String
    let ycoordinate: Float
    let xcoordinate: Float

    enum CodingKeys: String, CodingKey {
        case id, location, placeName, ticketPrice, isBookMarked, imageUrl, cultureName, wantedPeople, content, phoneNumber, isApplicationAble, applicationStartDate, applicationEndDate, serviceStartDate, serviceEndDate, serviceStartTime, serviceEndTime, cultureLink, ycoordinate, xcoordinate
    }
}

extension FetchCultureDetailResponseDTO {
    func toDomain() -> CultureDetailEntity {
        CultureDetailEntity(
            id: id,
            location: location,
            placeName: placeName,
            ticketPrice: ticketPrice,
            isBookMarked: isBookMarked,
            imageUrl: imageUrl,
            cultureName: cultureName,
            wantedPeople: wantedPeople,
            content: content,
            phoneNumber: phoneNumber,
            isApplicationAble: isApplicationAble,
            applicationStartDate: applicationStartDate,
            applicationEndDate: applicationEndDate,
            serviceStartDate: serviceStartDate,
            serviceEndDate: serviceEndDate,
            serviceStartTime: serviceStartTime,
            serviceEndTime: serviceEndTime,
            cultureLink: cultureLink,
            ycoordinate: ycoordinate,
            xcoordinate: xcoordinate
        )
    }
}
