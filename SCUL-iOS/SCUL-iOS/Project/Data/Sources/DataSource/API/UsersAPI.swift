import Moya

enum UsersAPI {
    case login(LoginRequest)
    case signup(SignupRequest)
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
        }
    }

    var method: Method {
        switch self {
        case .login, .signup:
            return .post
    }

    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)

        case let .signup(req):
            return .requestJSONEncodable(req)
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        default:
            return .none
        }
    }

    var errorMap: [Int: ErrorType]? {
        switch self {
        case .login:
            return [
                400: .badRequest,
                401: .notFoundPassword,
                404: .notFoundEmail,
                500: .internalServerError
            ]
        }
    }
}
