//
//  Fonts.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

extension Font {
    init(_ weight: Font.Weight) {
        self = .system(.body, weight: weight)
    }
}

class Fonts {
    var regularTextFont = Font(.regular)
    var selectedTextFont = Font(.semibold)
    var headerTextFont = Font(.semibold)
}
