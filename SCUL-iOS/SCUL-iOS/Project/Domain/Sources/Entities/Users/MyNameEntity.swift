import Foundation

public struct MyNameEntity: Equatable, Hashable {
    public let name: String

    public init(
        name: String
    ) {
        self.name = name
    }
}
