//
//  Fonts.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

extension Font {
    init(_ weight: Font.Weight, size: CGFloat) {
        self = .system(size: size, weight: weight)
    }
}

class Fonts {
    var regularTextFont: Font
    var selectedTextFont: Font
    var headerTextFont: Font
    
    init(regularWeight: Font.Weight = .regular,
         selectedWeight: Font.Weight = .semibold,
         headerWeight: Font.Weight = .semibold,
         customSize: CGFloat? = nil) {
        
        if let customSize = customSize {
            self.regularTextFont = .system(size: customSize, weight: regularWeight)
            self.selectedTextFont = .system(size: customSize, weight: selectedWeight)
            self.headerTextFont = .system(size: customSize, weight: headerWeight)
        } else {
            self.regularTextFont = .system(.body, weight: regularWeight)
            self.selectedTextFont = .system(.body, weight: selectedWeight)
            self.headerTextFont = .system(.headline, weight: headerWeight)
        }
    }
}
