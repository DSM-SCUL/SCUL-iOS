import Moya

enum CulturesAPI {
    case fetchCultureList
    case fetchCultureDetail(id: String)
    case searchCulture(name: String?)
}

extension CulturesAPI: SculAPI {
    typealias ErrorType = UsersError

    var domain: SculDomain {
        .cultures
    }

    var urlPath: String {
        switch self {
        case .fetchCultureList:
            return ""

        case let .fetchCultureDetail(id: id):
            return "/detail/\(id)"

        case .searchCulture:
            return "/search"
        }
    }

    var method: Method {
        switch self {
        case .fetchCultureList, .fetchCultureDetail, .searchCulture:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .searchCulture(name: name):
            return .requestParameters(
                parameters: [
                    "name": name ?? ""
                ], encoding: URLEncoding.queryString)

        case .fetchCultureList, .fetchCultureDetail:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        case .fetchCultureList, .fetchCultureDetail, .searchCulture:
            return .accessToken

//        default:
//            return .none
        }
    }

    var errorMap: [Int: ErrorType]? {
        switch self {
        case .fetchCultureList, .fetchCultureDetail, .searchCulture:
            return [
                400: .badRequest,
                401: .notFoundPassword,
                404: .notFoundEmail,
                500: .internalServerError
            ]
        }
    }
}

