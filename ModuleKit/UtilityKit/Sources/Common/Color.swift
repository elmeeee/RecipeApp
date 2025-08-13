//
//  Color.swift
//  ModuleKit
//
//  Created by Elmee on 13/08/25.
//

import Foundation
import SwiftUI

public extension Color {
    
    init(hex: String) {
        self.init(UIColor(hex: hex))
    }
    
    init(hex: String, alpha: Double) {
        self.init(UIColor(hex: hex, alpha: alpha))
    }
        
    static let primaryGreen50  = Color(hex: "#EEFBF8")
    static let primaryGreen100 = Color(hex: "#CAF2E8")
    static let primaryGreen200 = Color(hex: "#B0ECDD")
    static let primaryGreen300 = Color(hex: "#8CE4CD")
    static let primaryGreen400 = Color(hex: "#76DEC3")
    static let primaryGreen500 = Color(hex: "#54D6B4")
    static let primaryGreen600 = Color(hex: "#4CC3A4")
    static let primaryGreen700 = Color(hex: "#3C9880")
    static let primaryGreen800 = Color(hex: "#2E7663")
    static let primaryGreen900 = Color(hex: "#235A4C")
    static let neutral50  = Color(hex: "#FFFFFF")
    static let neutral100 = Color(hex: "#FAFAFA")
    static let neutral200 = Color(hex: "#F5F6F6")
    static let neutral300 = Color(hex: "#EBEDEC")
    static let neutral400 = Color(hex: "#EBECEE")
    static let neutral500 = Color(hex: "#B2B9B7")
    static let neutral600 = Color(hex: "#97A09E")
    static let neutral700 = Color(hex: "#798482")
    static let neutral800 = Color(hex: "#6A7774")
    static let neutral900 = Color(hex: "#11312A")
    static let secondaryBlue50  = Color(hex: "#E0EBFF")
    static let secondaryBlue100 = Color(hex: "#ADCAFF")
    static let secondaryBlue200 = Color(hex: "#8DB0F2")
    static let secondaryBlue300 = Color(hex: "#79A8FF")
    static let secondaryBlue400 = Color(hex: "#5F97FF")
    static let secondaryBlue500 = Color(hex: "#377DFF")
    static let secondaryBlue600 = Color(hex: "#3272E8")
    static let secondaryBlue700 = Color(hex: "#2759B5")
    static let secondaryBlue800 = Color(hex: "#1E458C")
    static let secondaryBlue900 = Color(hex: "#17356B")
    static let secondaryYellow50  = Color(hex: "#FFF9E6")
    static let secondaryYellow100 = Color(hex: "#FFECB2")
    static let secondaryYellow200 = Color(hex: "#FFE28D")
    static let secondaryYellow300 = Color(hex: "#FFD559")
    static let secondaryYellow400 = Color(hex: "#FFCD39")
    static let secondaryYellow500 = Color(hex: "#FFC107")
    static let secondaryYellow600 = Color(hex: "#E8B006")
    static let secondaryYellow700 = Color(hex: "#B58905")
    static let secondaryYellow800 = Color(hex: "#8C6A04")
    static let secondaryYellow900 = Color(hex: "#6B5103")
    static let secondaryRed50  = Color(hex: "#FDECEC")
    static let secondaryRed100 = Color(hex: "#F8C4C4")
    static let secondaryRed200 = Color(hex: "#F5A8A8")
    static let secondaryRed300 = Color(hex: "#F18080")
    static let secondaryRed400 = Color(hex: "#EE6767")
    static let secondaryRed500 = Color(hex: "#EA4141")
    static let secondaryRed600 = Color(hex: "#D53B3B")
    static let secondaryRed700 = Color(hex: "#A62E2E")
    static let secondaryRed800 = Color(hex: "#812424")
    static let secondaryRed900 = Color(hex: "#621B1B")
    static let secondaryGreen50  = Color(hex: "#EFFAF1")
    static let secondaryGreen100 = Color(hex: "#CEEED2")
    static let secondaryGreen200 = Color(hex: "#B6E6BC")
    static let secondaryGreen300 = Color(hex: "#95DB9E")
    static let secondaryGreen400 = Color(hex: "#81D48B")
    static let secondaryGreen500 = Color(hex: "#61C96E")
    static let secondaryGreen600 = Color(hex: "#58B764")
    static let secondaryGreen700 = Color(hex: "#458F4E")
    static let secondaryGreen800 = Color(hex: "#356F3D")
    static let secondaryGreen900 = Color(hex: "#29542E")
    static let fontWhite      = Color(hex: "#FDFDFF")
    static let fontBlack      = Color(hex: "#282828")
    static let fontGreenSaldo = Color(hex: "#7638FF")
    static let fontLightGrey  = Color(hex: "#D0D3D9")
    static let fontDarkGrey   = Color(hex: "#344256")
    static let iconDarkSurface  = Color(hex: "#FDFDFF")
    static let iconLightSurface = Color(hex: "#5D6878")
    static let iconGreenSaldo   = Color(hex: "#7638FF")
    static let iconLightGrey    = Color(hex: "#D0D3D9")
    static let iconDarkGrey     = Color(hex: "#282828")
    static let backgroundB0  = Color(hex: "#FFFFFF")
    static let backgroundB10 = Color(hex: "#F8F8F8")
    static let backgroundB20 = Color(hex: "#F5F6F7")
    static let backgroundB30 = Color(hex: "#EBEDF0")
}

public extension UIColor {
    convenience init(hex: String, alpha: Double = 1.0) {
        let cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let hexString = cleanedHex.hasPrefix("#") ? String(cleanedHex.dropFirst()) : cleanedHex
        
        guard hexString.count == 6 else {
            self.init(white: 1.0, alpha: CGFloat(alpha))
            return
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
}
