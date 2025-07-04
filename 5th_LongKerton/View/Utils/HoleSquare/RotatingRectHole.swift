import SwiftUI

struct RotatingRectHole: Shape {
    var angle: Angle
    var offsetX: CGFloat
    var offsetY: CGFloat
    var holeWidth: CGFloat
    var holeHeight: CGFloat
    var cornerRadius: CGFloat = 20

    var animatableData: AnimatablePair<
        AnimatablePair<AnimatablePair<Double, CGFloat>, CGFloat>,
        AnimatablePair<CGFloat, CGFloat>
    > {
        get {
            AnimatablePair(
                AnimatablePair(
                    AnimatablePair(angle.degrees, offsetX),
                    offsetY
                ),
                AnimatablePair(holeWidth, holeHeight)
            )
        }
        set {
            angle = .degrees(newValue.first.first.first)
            offsetX = newValue.first.first.second
            offsetY = newValue.first.second
            holeWidth = newValue.second.first
            holeHeight = newValue.second.second
        }
    }

    func path(in rect: CGRect) -> Path {
        let holeSize = CGSize(width: holeWidth, height: holeHeight)

        let center = CGPoint(
            x: rect.midX + offsetX,
            y: rect.midY + offsetY
        )

        let holeRect = CGRect(
            x: center.x - holeSize.width / 2,
            y: center.y - holeSize.height / 2,
            width: holeSize.width,
            height: holeSize.height
        )

        let anchor = CGPoint(
            x: holeRect.minX,
            y: holeRect.maxY - holeRect.height * 0.16
        )

        let transform = CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .rotated(by: CGFloat(angle.radians))
            .translatedBy(x: -anchor.x, y: -anchor.y)

        // ❌ path.addRect(rect) 제거!
        let rotatedHole = RoundedRectangle(cornerRadius: cornerRadius)
            .path(in: holeRect)
            .applying(transform)

        return rotatedHole
    }
}
