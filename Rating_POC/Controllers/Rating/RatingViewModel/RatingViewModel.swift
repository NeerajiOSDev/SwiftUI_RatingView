import SwiftUI

class RatingViewModel: ObservableObject {
    @Published var rating: Rating = .one
    @Published var smileHeight: CGFloat = 40
    @Published var bgColor: Color = .red

    func updateRating(_ newRating: Rating) {
        rating = newRating
        let properties = RatingModel.getFaceProperties(for: newRating)
        smileHeight = properties.smileHeight
        bgColor = properties.bgColor
    }
}
