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
    static let nickBox = Color(hex: 0x393939)
    static let nickBoxStroke = Color(hex: 0x5F5F5F)
    static let FashionText = Color(hex: 0xAFAFAF)
    static let FashBox = Color(hex: 0x16205B)
    static let lastBox = Color(hex: 0x294DEF)
    static let BgColor = Color(hex: 0x1B191A)
    static let EditBox = Color(hex: 0x6D6D6D)
    static let EditTxt = Color(hex: 0x878787)
    
    static let myGray = Color(hex: 0xCECECE)
    static let myDarkGray = Color(hex: 0x3E3E3E)
    static let myUnderline = Color(hex: 0x294DEF)

    
    static let pageDarkBlue = Color(hex: 0x001B66)
    static let pageBlue = Color(hex: 0x496FFF)
    static let myHomeGray = Color(hex: 0x2D2D2D)
    static let NickWhite = Color(hex: 0xD9D9D9)
    
    static let myGradStart = Color(hex: 0xBEBEC0)
    static let myGradEnd = Color(hex: 0x858486)
    static let myGradEnd2 = Color(hex: 0x496FFF)
    
    
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
