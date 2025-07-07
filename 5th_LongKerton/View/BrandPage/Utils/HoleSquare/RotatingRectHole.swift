import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `RotatingRectHole`은 SwiftUI의 `Shape` 프로토콜을 따르는 커스텀 도형입니다.
/// 이 도형은 회전하고 위치와 크기를 조절할 수 있는 둥근 사각형 형태의 "구멍"을 정의합니다.
struct RotatingRectHole: Shape {
    // MARK: - Properties

    var angle: Angle // 구멍의 회전 각도를 나타내는 속성입니다. `Angle` 타입으로, `.degrees`나 `.radians`로 설정할 수 있습니다.
    var offsetX: CGFloat // 구멍의 X축 오프셋을 나타내는 속성입니다. `rect.midX`를 기준으로 얼마나 이동할지 결정합니다.
    var offsetY: CGFloat // 구멍의 Y축 오프셋을 나타내는 속성입니다. `rect.midY`를 기준으로 얼마나 이동할지 결정합니다.
    var holeWidth: CGFloat // 구멍의 너비를 나타내는 속성입니다.
    var holeHeight: CGFloat // 구멍의 높이를 나타내는 속성입니다.
    var cornerRadius: CGFloat = 20 // 구멍의 둥근 모서리 반지름을 나타내는 속성입니다. 기본값은 20입니다.

    // MARK: - Animatable Conformance

    /// `Animatable` 프로토콜을 준수하기 위한 요구사항입니다.
    /// 이 속성을 통해 `angle`, `offsetX`, `offsetY`, `holeWidth`, `holeHeight` 속성이 애니메이션될 수 있습니다.
    /// SwiftUI는 이 `animatableData`를 사용하여 속성 변경에 따른 중간 값을 보간합니다.
    var animatableData: AnimatablePair< // 애니메이션 가능한 데이터를 중첩된 `AnimatablePair`로 묶습니다.
        AnimatablePair<AnimatablePair<Double, CGFloat>, CGFloat>, // 첫 번째 쌍: (angle.degrees, offsetX), offsetY
        AnimatablePair<CGFloat, CGFloat> // 두 번째 쌍: (holeWidth, holeHeight)
    > {
        get {
            // 현재 속성 값들을 `AnimatablePair` 구조에 맞게 변환하여 반환합니다.
            // `angle.degrees`는 `Double` 타입으로 변환하여 사용합니다.
            AnimatablePair(
                AnimatablePair(
                    AnimatablePair(angle.degrees, offsetX),
                    offsetY
                ),
                AnimatablePair(holeWidth, holeHeight)
            )
        }
        set {
            // `AnimatablePair`에서 받은 새로운 값들을 해당 속성에 할당합니다.
            // 애니메이션이 진행됨에 따라 SwiftUI가 이 `setter`를 호출하여 중간 값들을 업데이트합니다.
            angle = .degrees(newValue.first.first.first) // 첫 번째 쌍의 첫 번째 쌍의 첫 번째 값 (angle.degrees)
            offsetX = newValue.first.first.second // 첫 번째 쌍의 첫 번째 쌍의 두 번째 값 (offsetX)
            offsetY = newValue.first.second // 첫 번째 쌍의 두 번째 값 (offsetY)
            holeWidth = newValue.second.first // 두 번째 쌍의 첫 번째 값 (holeWidth)
            holeHeight = newValue.second.second // 두 번째 쌍의 두 번째 값 (holeHeight)
        }
    }

    // MARK: - Path Definition

    /// `Shape` 프로토콜의 핵심 요구사항입니다. 주어진 `rect` (도형이 그려질 영역) 내에서 도형의 경로를 정의합니다.
    /// 이 메서드는 도형의 시각적 형태를 결정합니다.
    /// - Parameter rect: 도형이 그려질 사각형 영역입니다.
    /// - Returns: 정의된 도형의 `Path` 객체입니다.
    func path(in rect: CGRect) -> Path {
        // 구멍의 크기를 정의합니다.
        let holeSize = CGSize(width: holeWidth, height: holeHeight)

        // 구멍의 중심 좌표를 계산합니다.
        // `rect`의 중앙에서 `offsetX`와 `offsetY`만큼 오프셋됩니다.
        let center = CGPoint(
            x: rect.midX + offsetX,
            y: rect.midY + offsetY
        )

        // 구멍의 사각형 영역을 정의합니다.
        // 중심 좌표와 너비, 높이를 기반으로 구멍의 CGRect를 계산합니다.
        let holeRect = CGRect(
            x: center.x - holeSize.width / 2, // 구멍 사각형의 시작 X 좌표
            y: center.y - holeSize.height / 2, // 구멍 사각형의 시작 Y 좌표
            width: holeSize.width, // 구멍 사각형의 너비
            height: holeSize.height // 구멍 사각형의 높이
        )

        // 회전 변환의 앵커 포인트를 정의합니다.
        // 이 예시에서는 구멍 사각형의 좌측 하단에서 높이의 12.5% 위 지점을 앵커로 사용합니다.
        // 이 앵커 포인트를 중심으로 구멍이 회전하게 됩니다.
        let anchor = CGPoint(
            x: holeRect.minX, // 구멍 사각형의 최소 X 좌표 (좌측)
            y: holeRect.maxY - holeRect.height * 0.125 // 구멍 사각형의 최대 Y 좌표 (하단)에서 높이의 12.5% 위
        )

        // 회전 변환을 생성합니다.
        // 1. `anchor` 지점으로 이동합니다 (`translatedBy`).
        // 2. 현재 `angle`만큼 회전합니다 (`rotated(by:)`).
        // 3. 다시 `anchor` 지점에서 원래 위치로 돌아옵니다 (`translatedBy`의 역변환).
        // 이 순서는 `anchor`를 중심으로 회전하도록 보장합니다.
        let transform = CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .rotated(by: CGFloat(angle.radians)) // `Angle`의 `radians` 값을 사용하여 회전합니다.
            .translatedBy(x: -anchor.x, y: -anchor.y) // 회전 후 원래 위치로 되돌립니다.

        // ❌ path.addRect(rect) 제거!
        // 이 줄은 원본 코드에서 주석 처리되어 있습니다.
        // 만약 이 줄이 활성화되어 있다면, 도형 전체 영역(`rect`)을 경로에 추가하게 되어
        // "구멍"이 아니라 단순히 전체 사각형이 그려질 수 있습니다.
        // 현재 이 도형은 "구멍" 자체의 경로만을 반환하도록 설계되었습니다.

        // 둥근 사각형 경로를 생성하고, 계산된 변환을 적용합니다.
        let rotatedHole = RoundedRectangle(cornerRadius: cornerRadius) // 지정된 `cornerRadius`로 둥근 사각형을 만듭니다.
            .path(in: holeRect) // `holeRect` 내부에 둥근 사각형의 경로를 생성합니다.
            .applying(transform) // 위에서 정의한 회전 변환을 이 경로에 적용합니다.

        // 최종적으로 변환이 적용된 둥근 사각형의 경로를 반환합니다.
        // 이 경로는 이 `Shape`의 최종 모양이 됩니다.
        return rotatedHole
    }
}
