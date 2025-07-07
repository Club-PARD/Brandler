import SwiftUI // SwiftUI 프레임워크 임포트

// MARK: - 상단만 둥근 모서리를 가지는 사각형 Shape
struct TopRoundedRectangle: Shape {
    var radius: CGFloat // 둥근 정도를 설정하는 반지름

    func path(in rect: CGRect) -> Path {
        var path = Path() // 경로를 그릴 Path 객체 생성

        // 시작점을 왼쪽 위 모서리 (radius만큼 오른쪽)로 이동
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))

        // 상단 직선을 오른쪽 위 둥근 모서리까지 그림
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        
        // 오른쪽 위 둥근 모서리 (quarter-circle)
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(0),
                    clockwise: false)

        // 오른쪽 수직 선
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // 하단 수평 선
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        // 왼쪽 수직 선 (위쪽 둥근 모서리 전까지)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        
        // 왼쪽 위 둥근 모서리 (quarter-circle)
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        return path // 완성된 경로 반환
    }
}

// MARK: - 하단 테두리를 제외한 외곽선만 그리는 Shape
struct StrokeExcludingBottom: Shape {
    var radius: CGFloat // 상단 둥근 정도 설정

    func path(in rect: CGRect) -> Path {
        var path = Path() // 경로 생성

        // 네 모서리 좌표 정의
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        // 시작점을 좌하단에서 시작
        path.move(to: bottomLeft)
        
        // 왼쪽 상단 둥근 모서리까지 수직선
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + radius))
        
        // 좌상단 둥근 코너
        path.addQuadCurve(to: CGPoint(x: topLeft.x + radius, y: topLeft.y), control: topLeft)

        // 상단 직선
        path.addLine(to: CGPoint(x: topRight.x - radius, y: topRight.y))
        
        // 우상단 둥근 코너
        path.addQuadCurve(to: CGPoint(x: topRight.x, y: topRight.y + radius), control: topRight)

        // 오른쪽 하단까지 수직선
        path.addLine(to: bottomRight)

        return path // 완성된 경로 반환
    }
}

// MARK: - 사용할 코너 방향을 지정할 enum
enum Corner {
    case topLeft, topRight, bottomLeft, bottomRight
}

// MARK: - 지정된 코너만 둥글게 처리하는 사각형 Shape
struct CustomRoundedCorner: Shape {
    var radius: CGFloat // 둥근 정도 설정
    var corners: [Corner] // 둥글게 처리할 코너 배열

    func path(in rect: CGRect) -> Path {
        var path = Path() // 경로 생성

        // 각 코너의 반지름 설정
        let topLeft = corners.contains(.topLeft) ? radius : 0
        let topRight = corners.contains(.topRight) ? radius : 0
        let bottomLeft = corners.contains(.bottomLeft) ? radius : 0
        let bottomRight = corners.contains(.bottomRight) ? radius : 0

        // 시작점: 좌상단
        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))

        // 상단 → 우상단 둥근 처리
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        if topRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
                        radius: topRight,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(0),
                        clockwise: false)
        }

        // 우측 → 우하단 둥근 처리
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        if bottomRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
                        radius: bottomRight,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
        }

        // 하단 → 좌하단 둥근 처리
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        if bottomLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
                        radius: bottomLeft,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
        }

        // 좌측 → 좌상단 둥근 처리
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        if topLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
                        radius: topLeft,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
        }

        return path // 완성된 경로 반환
    }
}

// MARK: - 특정 위치(gap)를 제외하고 라운드 테두리를 그리는 Shape
struct CustomRoundedCornerWithFixedGap: Shape {
    var radius: CGFloat // 둥근 반지름
    var corners: [Corner] // 둥글게 처리할 코너
    var gapStartX: CGFloat = 0 // 생략할 구간 시작 X
    var gapEndX: CGFloat = 0   // 생략할 구간 끝 X

    func path(in rect: CGRect) -> Path {
        var path = Path() // 경로 생성

        // 각 코너별 반지름 설정
        let topLeftRadius = corners.contains(.topLeft) ? radius : 0
        let topRightRadius = corners.contains(.topRight) ? radius : 0
        let bottomLeftRadius = corners.contains(.bottomLeft) ? radius : 0
        let bottomRightRadius = corners.contains(.bottomRight) ? radius : 0

        // 시작점: 좌상단 (radius 보정 포함)
        let safeStartX = max(rect.minX + topLeftRadius, rect.minX)
        path.move(to: CGPoint(x: safeStartX, y: rect.minY))

        // gap 시작점까지 선 그리기
        if gapStartX > safeStartX {
            path.addLine(to: CGPoint(x: gapStartX, y: rect.minY))
        }

        // gap 구간 생략 (이동)
        path.move(to: CGPoint(x: gapEndX, y: rect.minY))

        // gap 이후 상단 → 우상단
        if gapEndX < rect.maxX - topRightRadius {
            path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        }

        // 우상단 둥글게
        if topRightRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
                        radius: topRightRadius,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(0),
                        clockwise: false)
        }

        // 우측 → 우하단 둥글게
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        if bottomRightRadius > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
                        radius: bottomRightRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(90),
                        clockwise: false)
        }

        // 하단 → 좌하단 둥글게
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        if bottomLeftRadius > 0 {
            path.addArc(center: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
                        radius: bottomLeftRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
        }

        // 좌측 → 좌상단 둥글게
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        if topLeftRadius > 0 {
            path.addArc(center: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
                        radius: topLeftRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)
        }

        return path // 완성된 경로 반환
    }
}
