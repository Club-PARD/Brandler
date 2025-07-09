import SwiftUI
import UIKit

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
    static let lastTxt = Color(hex: 0x9F9F9F)
    static let blueUnderline = Color(hex: 0x294DEF)
    
    static let myGray = Color(hex: 0xCECECE)
    static let myDarkGray = Color(hex: 0x3E3E3E)
    static let myUnderline = Color(hex: 0x294DEF)
    
    static let circleStep = Color(hex: 0x9A9A9A)
    static let levelGray = Color(hex: 0xC6C6C6)
    static let semiGray = Color(hex: 0xF8F8F8)
    
    static let pageDarkBlue = Color(hex: 0x001B66)
    static let pageBlue = Color(hex: 0x496FFF)
    static let myHomeGray = Color(hex: 0x2D2D2D)
    static let NickWhite = Color(hex: 0xD9D9D9)
    
    static let myGradStart = Color(hex: 0xBEBEC0)
    static let myGradEnd = Color(hex: 0x858486)
    static let myGradEnd2 = Color(hex: 0x496FFF)
    
    //tab
    static let TabPurple = Color(hex: 0xD0D4E4)
    static let TabGray = Color(hex: 0x959595)
    
    //modal
    static let ModalBackground1 = Color(hex: 0xF3F3F3)
    static let ModalBackground2 = Color(hex: 0xE0E0E0)
    static let ModalBackground3 = Color(hex: 0xCECECE)
    static let ContentBackground = Color(hex: 0x506CA6)
    
    
    
    //SearchPage
    static let ProductBackGround = Color(hex: 0xE5E5E5)
    static let EmptyFontColor = Color(hex: 0x6D6D6D)
    
    
    //BrandScape
    static let BackgroundBlue = Color(hex: 0x3B55BB)
    static let Gradient1 = Color(hex: 0xF8F8F8)
    static let Gradient2 = Color(hex: 0xBEBEC0)
    static let Gradient3 = Color(hex: 0xDBDBDC)
    static let Gradient4 = Color(hex: 0x7E7E7F)
    static let Gradient5 = Color(hex: 0x3E3E3E)
    
    static let ScrollPoint = Color(hex: 0x0022FF)
    static let BrandCardFontColor = Color(hex: 0x9F9F9F)
    static let GuideFontColor = Color(hex: 0xCDFF5D)
    

    
    //BrandPage
    static let Inter = Color(hex: 0x0038FF)
    
    static let Kakao = Color(hex: 0xFDE500)
    static let BrandGenre = Color(hex: 0x373737)
    static let BrandFont = Color(hex: 0x868686)
    
    static func interpolateHex(from: Color, to: Color, fraction: CGFloat) -> Color {
        let clampedFraction = min(max(fraction, 0), 1)

        let fromUIColor = UIColor(from)
        let toUIColor = UIColor(to)

        var fr: CGFloat = 0, fg: CGFloat = 0, fb: CGFloat = 0, fa: CGFloat = 0
        var tr: CGFloat = 0, tg: CGFloat = 0, tb: CGFloat = 0, ta: CGFloat = 0

        fromUIColor.getRed(&fr, green: &fg, blue: &fb, alpha: &fa)
        toUIColor.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)

        let r = fr + (tr - fr) * clampedFraction
        let g = fg + (tg - fg) * clampedFraction
        let b = fb + (tb - fb) * clampedFraction
        let a = fa + (ta - fa) * clampedFraction

        return Color(red: r, green: g, blue: b, opacity: a)
    }
}
