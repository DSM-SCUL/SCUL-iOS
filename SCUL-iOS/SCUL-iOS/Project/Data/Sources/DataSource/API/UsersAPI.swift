import Moya

enum UsersAPI {
    case login(LoginRequest)
    case signup(SignupRequest)
    case fetchMyName
}

extension UsersAPI: SculAPI {
    typealias ErrorType = UsersError

    var domain: SculDomain {
        .users
    }

    var urlPath: String {
        switch self {
        case .login:
            return "/login"
            
        case .signup:
            return "/signup"

        case .fetchMyName:
            return "/name"
        }
    }

    var method: Method {
        switch self {
        case .login, .signup:
            return .post

        case .fetchMyName:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)
            
        case let .signup(req):
            return .requestJSONEncodable(req)

        case .fetchMyName:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        case .fetchMyName:
            return .accessToken

        default:
            return .none
        }
    }

    var errorMap: [Int: ErrorType]? {
        switch self {
        case .login, .signup, .fetchMyName:
            return [
                400: .badRequest,
                401: .notFoundPassword,
                404: .notFoundEmail,
                500: .internalServerError
            ]
        }
    }
}

