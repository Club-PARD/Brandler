import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
    
    // Example: Define your theme colors as static properties
    static let backgroundBlueGray = Color(hex: 0xF2F5FF)
    static let barBlue = Color(hex: 0x002FFF)
    static let buttonGray = Color(hex: 0xBDBDBD)
    static let NextButton = Color(hex: 0x8D8D8D)    
    static let DarkGr = Color(hex: 0x5B5B5B)
    static let LogBlue = Color(hex: 0xC4D1FF)
    static let barBlack = Color(hex: 0x3A3A3A)
    static let nickBox = Color(hex: 0x4A4A4A)
    static let BgColor = Color(hex: 0x1B191A)
    static let EditBox = Color(hex: 0x6D6D6D)

    
}


/* how to use
 ZStack {
     Color.backgroundGray.ignoresSafeArea()
     VStack {
         // ... your content ...
         RoundedRectangle(cornerRadius: 6)
             .fill(Color.boxGray)
         Button(action: {}) {
             Text("디깅하러 고고링")
                 .foregroundColor(.white)
                 .frame(maxWidth: .infinity, minHeight: 48)
                 .background(Color.buttonGray)
                 .cornerRadius(24)
         }
     }
 }
*/
