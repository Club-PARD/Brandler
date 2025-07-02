import SwiftUI

struct ScrollThumbPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ScrollThumbViewController {
        return ScrollThumbViewController()
    }

    func updateUIViewController(_ uiViewController: ScrollThumbViewController, context: Context) {
        // 필요 시 상태 업데이트
    }
}
