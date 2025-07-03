import SwiftUI

import SwiftUI

struct TopRoundedRectangle: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 왼쪽 위 시작점
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))

        // 상단 선 + 오른쪽 위 둥근 모서리
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(0),
                    clockwise: false)

        // 오른쪽 라인
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // 하단 라인
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        // 왼쪽 라인 + 왼쪽 위 둥근 모서리
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        return path
    }
}

enum Corner {
    case topLeft, topRight, bottomLeft, bottomRight
}

struct CustomRoundedCorner: Shape {
    var radius: CGFloat
    var corners: [Corner]

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topLeft = corners.contains(.topLeft) ? radius : 0
        let topRight = corners.contains(.topRight) ? radius : 0
        let bottomLeft = corners.contains(.bottomLeft) ? radius : 0
        let bottomRight = corners.contains(.bottomRight) ? radius : 0

        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))

        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        if topRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
                        radius: topRight,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(0),
                        clockwise: false)
        }

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        if bottomRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
                        radius: bottomRight,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
        }

        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        if bottomLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
                        radius: bottomLeft,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
        }

        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        if topLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
                        radius: topLeft,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
        }

        return path
    }
}
