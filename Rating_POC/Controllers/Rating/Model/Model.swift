import SwiftUI

enum Rating: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}

struct RatingModel {
    static func getFaceProperties(for rating: Rating) -> (smileHeight: CGFloat, bgColor: Color) {
        switch rating {
        case .one:
            return (40, .one)
        case .two:
            return (40, .two)
        case .three:
            return (40, .three)
        case .four:
            return (40, .four)
        case .five:
            return (40, .five)
        }
    }
}
