//
//  Colors.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

class Colors {
    //MARK: - Text Colors
    var normalDarkTextColor: Color = .white
    var normalTextColor: Color = .black
    
    var selectedDarkTextColor = Color(hex: 0x00A3FF)
    var selectedTextColor = Color(hex: 0xBC0A79)
    
    var weekdayTextColor = Color(hex: 0x9D9D9D)
    
    //MARK: - Back Colors
    var backgroundDarkColor = Color(hex: 0x2A3038)
    var backgroundColor: Color = .white
    
    var disabledDarkBackColor = Color(hex: 0x14181E)
    var disabledBackColor = Color(hex: 0xEBEBF5, opacity: 0.8)
    
    var selectedDarkBackColor = Color(hex: 0x00A3FF, opacity: 0.12)
    var selectedBackColor = Color(hex: 0xBC0A79, opacity: 0.12)
    
    var betweenDarkBackColor = Color(hex: 0x00A3FF, opacity: 0.12)
    var betweenBackColor = Color(hex: 0xBC0A79, opacity: 0.12)
    
    //MARK: - Border Colors
    var holidayBorderColor = Color(hex: 0xBC0A79)
    var disabledBorderColor = Color(hex: 0x00A3FF)
    var normalBorderColor = Color.white
}
