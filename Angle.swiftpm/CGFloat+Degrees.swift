import CoreGraphics

extension CGFloat {
    func radiansToDegrees() -> CGFloat {
        self * 360 / (.pi * 2)
    }
    
    func degreesToRadians() -> CGFloat {
        self * .pi * 2 / 360
    }
}
