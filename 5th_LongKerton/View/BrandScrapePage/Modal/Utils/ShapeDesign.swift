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


struct StrokeExcludingBottom: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        // 상단 좌측 → 상단 라운드 → 상단 우측 → 우측 하단 → 좌측 하단 (하단 선 제외)
        path.move(to: bottomLeft)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + radius))
        path.addQuadCurve(to: CGPoint(x: topLeft.x + radius, y: topLeft.y), control: topLeft)
        path.addLine(to: CGPoint(x: topRight.x - radius, y: topRight.y))
        path.addQuadCurve(to: CGPoint(x: topRight.x, y: topRight.y + radius), control: topRight)
        path.addLine(to: bottomRight)

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


struct CustomRoundedCornerWithFixedGap: Shape {
    var radius: CGFloat
    var corners: [Corner]
    
    var gapStartX: CGFloat = 0    // 공백 시작 X
    var gapEndX: CGFloat = 0      // 공백 끝 X

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topLeftRadius = corners.contains(.topLeft) ? radius : 0
        let topRightRadius = corners.contains(.topRight) ? radius : 0
        let bottomLeftRadius = corners.contains(.bottomLeft) ? radius : 0
        let bottomRightRadius = corners.contains(.bottomRight) ? radius : 0

        // 좌상단 시작
        let safeStartX = max(rect.minX + topLeftRadius, rect.minX)
        path.move(to: CGPoint(x: safeStartX, y: rect.minY))

        // ➤ gap 전까지 선
        if gapStartX > safeStartX {
            path.addLine(to: CGPoint(x: gapStartX, y: rect.minY))
        }

        // ➤ gap 건너뜀
        path.move(to: CGPoint(x: gapEndX, y: rect.minY))

        // ➤ gap 이후 선
        if gapEndX < rect.maxX - topRightRadius {
            path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        }

        // 나머지 둥근 테두리 처리
        if topRightRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
                        radius: topRightRadius,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(0),
                        clockwise: false)
        }

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        if bottomRightRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
                        radius: bottomRightRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
        }

        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        if bottomLeftRadius > 0 {
            path.addArc(center: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
                        radius: bottomLeftRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
        }

        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        if topLeftRadius > 0 {
            path.addArc(center: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
                        radius: topLeftRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
        }

        return path
    }
}
