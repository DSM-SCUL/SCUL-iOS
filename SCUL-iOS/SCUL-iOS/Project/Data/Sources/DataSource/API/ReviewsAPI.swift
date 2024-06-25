import Moya

enum ReviewsAPI {
    case fetchReviewList(id: String)
    case fetchMyReviewList
}

extension ReviewsAPI: SculAPI {
    typealias ErrorType = UsersError

    var domain: SculDomain {
        .reviews
    }

    var urlPath: String {
        switch self {
        case let .fetchReviewList(id):
            return "/\(id)"

        case .fetchMyReviewList:
            return ""
        }
    }

    var method: Method {
        switch self {
        case .fetchMyReviewList, .fetchReviewList:
            return .get
        }
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        default:
            return .accessToken
        }
    }

    var errorMap: [Int: ErrorType]? {
        switch self {
        case .fetchMyReviewList, .fetchReviewList:
            return [
                400: .badRequest,
                401: .notFoundPassword,
                404: .notFoundEmail,
                500: .internalServerError
            ]
        }
    }
}

