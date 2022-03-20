import SwiftUI

struct AngleView: View {
    @State var angle: Angle = .degrees(45)
    @State var isEditing: Bool = false
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                isEditing = true
                let corner = CGPoint(x: 300, y: 300)
                let deltaX = corner.x - value.location.x
                let deltaY = corner.y - value.location.y
                let dragAngle = atan2(deltaY, deltaX)
                
                var transaction = Transaction(animation: .none)
                transaction.disablesAnimations = true

                withTransaction(transaction) {
                    angle = .radians(dragAngle)
                }
             
            }
            .onEnded { value in
                isEditing = false
            }
    }
    
    var body: some View {
        VStack {
            Label("Angle", systemImage: "arrow.clockwise")
                .font(.title)
            ZStack {
                WedgeShape(angle: angle)
                    .fill(.thickMaterial)
                AngleShape(angle: angle, isEditing: isEditing)
                    .stroke(.foreground,  style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))

            }
            .frame(width: 400, height: 400)
            .animation(.default, value: angle)
            .gesture(dragGesture)
            Stepper("\(Int(round(angle.degrees)))°", value: $angle.degrees, step: 15)
        }
    }
}
