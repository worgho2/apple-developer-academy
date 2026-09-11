import Foundation

enum CustomError: String, Error {
    case unexpected = "Unexpected error"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
}

extension CustomError: CustomStringConvertible, LocalizedError {
    var isFatal: Bool {
        return [
            CustomError.unexpected
        ].contains(where: {$0 == self})
    }
    
    public var description: String {
        return self.rawValue
    }
    
    public var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
    
}
