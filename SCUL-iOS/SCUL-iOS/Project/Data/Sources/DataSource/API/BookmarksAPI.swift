import Moya

enum BookmarksAPI {
    case bookmark(id: String)
    case fetchBookmarkList
}

extension BookmarksAPI: SculAPI {
    typealias ErrorType = UsersError

    var domain: SculDomain {
        .bookmarks
    }

    var urlPath: String {
        switch self {
        case let .bookmark(id):
            return "/\(id)"

        case .fetchBookmarkList:
            return ""
        }
    }

    var method: Method {
        switch self {
        case .bookmark:
            return .post

        case .fetchBookmarkList:
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
        default:
            return nil
        }
    }
}

