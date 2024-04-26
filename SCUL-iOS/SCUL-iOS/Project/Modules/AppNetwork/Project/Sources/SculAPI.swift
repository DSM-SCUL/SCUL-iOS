import Foundation
import Moya

public protocol SculAPI: TargetType, JwtAuthorizable {
    associatedtype ErrorType: Error
    var domain: SculDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: ErrorType]? { get }
}

public extension SculAPI {
    var baseURL: URL {
        URL(
            string: Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
        ) ?? URL(string: "https://www.google.com")!
    }

    var path: String {
        domain.asURLString + urlPath
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

public enum SculDomain: String {
    case users
    case reviews
    case bookMarks
    case cultures
}

extension SculDomain {
    var asURLString: String {
        "/\(self.rawValue)"
    }
}

private class BundleFinder {}

extension Foundation.Bundle {
    static let module = Bundle(for: BundleFinder.self)
}
