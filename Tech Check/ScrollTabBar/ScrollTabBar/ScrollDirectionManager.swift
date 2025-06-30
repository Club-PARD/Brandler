import SwiftUI

class ScrollDirectionManager: ObservableObject {
    @Published var isTabBarHidden: Bool = false

    private var lastOffset: CGFloat = 0
    private var lastDirection: ScrollDirection = .none

    enum ScrollDirection {
        case up, down, none
    }

    func updateScroll(offset: CGFloat) {
        let delta = offset - lastOffset

        if delta > 5 {
            if lastDirection != .up {
                isTabBarHidden = false
                lastDirection = .up
            }
        } else if delta < -5 {
            if lastDirection != .down {
                isTabBarHidden = true
                lastDirection = .down
            }
        }

        lastOffset = offset
    }
}
