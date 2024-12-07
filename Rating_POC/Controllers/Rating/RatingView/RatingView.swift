import SwiftUI

struct RatingView: View {
    @StateObject private var viewModel = RatingViewModel()  // Initialize ViewModel
    
    var body: some View {
        VStack {
            // Top Header and Rating prompt
            VStack {
                HStack {
                    Text("Hi, Name")
                        .foregroundStyle(Color.gray)
                        .font(.system(size: 26).bold())
                    Spacer()
                }
                Text("Please rate us!")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 22).bold())
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 60, trailing: 0))
                
                ZStack {
                    Circle()
                        .fill(viewModel.bgColor)
                        .frame(width: 250, height: 250)
                    
                    VStack {
                        HStack(spacing: 30) {
                            switch viewModel.rating {
                            case .one:
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 10)
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 10)
                            case .two:
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 20)
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 20)
                            case .three, .four, .five:
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 50)
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        
                        SmileyFace(rating: viewModel.rating.rawValue, smileHeight: viewModel.smileHeight)
                            .stroke(lineWidth: 8)
                            .frame(width: 160, height: 160)
                    }
                    .padding(EdgeInsets(top: 90, leading: 0, bottom: 0, trailing: 0))
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 60, leading: 10, bottom: 0, trailing: 10))
            
            // Rating Stars Bar
            HStack(spacing: 20) {
                ForEach(1..<6) { star in
                    StarView(isSelected: star <= viewModel.rating.rawValue)
                        .onTapGesture {
                            viewModel.updateRating(Rating(rawValue: star)!)
                        }
                }
            }
            .padding(.bottom, 40)
        }
        
        .ignoresSafeArea()
    }
}

struct SmileyFace: Shape {
    var rating: Int
    var smileHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let smileCenterY = rect.midY - smileHeight
        let smileWidth: CGFloat = rect.width - 70
        let smileHeight: CGFloat = 50
        
        switch rating {
        case 1:
            path.move(to: CGPoint(x: rect.midX - smileWidth / 2, y: smileCenterY))
            path.addLine(to: CGPoint(x: rect.midX - smileWidth / 4, y: smileCenterY - 10))
            path.addLine(to: CGPoint(x: rect.midX, y: smileCenterY + 10))
            path.addLine(to: CGPoint(x: rect.midX + smileWidth / 4, y: smileCenterY - 10))
            path.addLine(to: CGPoint(x: rect.midX + smileWidth / 2, y: smileCenterY))
        case 2:
            path.move(to: CGPoint(x: rect.midX - smileWidth / 2, y: smileCenterY + 20))
            path.addLine(to: CGPoint(x: rect.midX + smileWidth / 2, y: smileCenterY))
        case 3:
            path.move(to: CGPoint(x: rect.midX - smileWidth / 2, y: smileCenterY))
            path.addLine(to: CGPoint(x: rect.midX + smileWidth / 2, y: smileCenterY))
        case 4:
            path.move(to: CGPoint(x: rect.midX - smileWidth / 2, y: smileCenterY))
            path.addQuadCurve(to: CGPoint(x: rect.midX + smileWidth / 2, y: smileCenterY), control: CGPoint(x: rect.midX, y: smileCenterY + smileHeight / 2))
        case 5:
            path.move(to: CGPoint(x: rect.midX - smileWidth / 2, y: smileCenterY))
            path.addQuadCurve(to: CGPoint(x: rect.midX + smileWidth / 2, y: smileCenterY), control: CGPoint(x: rect.midX, y: smileCenterY + smileHeight))
        default:
            break
        }
        
        return path
    }
}

struct StarView: View {
    var isSelected: Bool
    
    var body: some View {
        Image(systemName: isSelected ? "star.fill" : "star")
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(isSelected ? .yellow : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

#Preview {
    ContentView()
}
