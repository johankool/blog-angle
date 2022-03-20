import SwiftUI

struct AngleShape: Shape {
    var angle: Angle
    let isEditing: Bool
    
    var animatableData: Angle {
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
        
        let hypotenuse: CGFloat = insetRect.maxX - insetRect.minX
        let adjacent = hypotenuse * cos(angle.radians)
        let opposite = hypotenuse * sin(angle.radians)
        let x = insetRect.minX + hypotenuse - adjacent
        let y = insetRect.minY + hypotenuse - opposite
        path.addLine(to: CGPoint(x: x, y: y))
        
        if isEditing {
            let editCircleRect = CGRect(origin: CGPoint(x: x - 10, y: y - 10), size: CGSize(width: 20, height: 20))
            path.addEllipse(in: editCircleRect)
        }
            
        return path
    }
}

