import PlaygroundSupport
import SwiftUI

struct AngleView: View {
    
    @State var angle: CGFloat = 45
    
    var body: some View {
        VStack {
            Label("Angle", systemImage: "arrow.clockwise")
                .font(.title)
            AngleShape(angle: angle)
                .stroke(.foreground,  style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 400, height: 400)
                .animation(.default, value: angle)
            Stepper("\(Int(round(angle)))°", value: $angle, step: 5)
        }
    }
}

struct AngleShape: Shape {
    var angle: CGFloat
    
    var animatableData: CGFloat {
        get { angle }
        set { angle = newValue }
    }
    
    var insets: UIEdgeInsets = .init(top: 100, left: 100, bottom: 100, right: 100)
   
    func path(in rect: CGRect) -> Path {
        let insetRect = rect.inset(by: insets)
        assert(insetRect.width == insetRect.height, "Rect must be square")
        
        var path = Path()
        path.move(to: CGPoint(x: insetRect.minX, y: insetRect.maxY))
        path.addLine(to: CGPoint(x: insetRect.maxX, y: insetRect.maxY))
        
        let angleInRadians = angle.degreesToRadians()
        let hypotenuse: CGFloat = insetRect.maxX - insetRect.minX
        let adjacent = hypotenuse * cos(angleInRadians)
        let opposite = hypotenuse * sin(angleInRadians)
        let x = insetRect.minX + hypotenuse - adjacent
        let y = insetRect.minY + hypotenuse - opposite
        path.addLine(to: CGPoint(x: x, y: y))
        
        return path
    }
}

extension CGFloat {
    func radiansToDegrees() -> CGFloat {
        self * 360 / (.pi * 2)
    }
    
    func degreesToRadians() -> CGFloat {
        self * .pi * 2 / 360
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.setLiveView(AngleView())
