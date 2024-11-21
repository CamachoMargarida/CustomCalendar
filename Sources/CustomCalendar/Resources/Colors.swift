//
//  Colors.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

extension Color {
    public init(hex: Int, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

public class Colors {
    //MARK: - Text Colors
    var normalTextColor: Color = .black
    var selectedTextColor = Color(hex: 0xBC0A79)
    var weekdayTextColor = Color(hex: 0x9D9D9D)
    var pickerTextColor: Color = .white
    var holidayTextColor: Color = .white
    var absenceTextColor: Color = .white
    var eventTextColor = Color(hex: 0xBC0A79)
    
    //MARK: - Back Colors
    var backgroundColor: Color = .white
    var absenceBackColor = Color(hex: 0xEBEBF5, opacity: 0.8)
    var selectedBackColor = Color(hex: 0xBC0A79, opacity: 0.12)
    var betweenBackColor = Color(hex: 0xBC0A79, opacity: 0.12)
    var holidayBackColor = Color(hex: 0xEBEBF5, opacity: 0.8)
    var pickerBackColor: Color = .white
    var eventBackColor = Color(hex: 0xBC0A79, opacity: 0.12)
    
    //MARK: - Border Colors
    var holidayBorderColor = Color(hex: 0xBC0A79)
    var absenceBorderColor = Color(hex: 0x00A3FF)
    var normalBorderColor: Color = .white
    
    public init(normalTextColor: Color = .black, selectedTextColor: Color = Color(hex: 0xBC0A79), weekdayTextColor: Color = Color(hex: 0x9D9D9D), pickerTextColor: Color = .white, holidayTextColor: Color = .white, absenceTextColor: Color = .white, backgroundColor: Color = .white, absenceBackColor: Color = Color(hex: 0xEBEBF5, opacity: 0.8), selectedBackColor: Color = Color(hex: 0xBC0A79, opacity: 0.12), betweenBackColor: Color = Color(hex: 0xBC0A79, opacity: 0.12), holidayBackColor: Color = Color(hex: 0xEBEBF5, opacity: 0.8), pickerBackColor: Color = .white, holidayBorderColor: Color = Color(hex: 0xBC0A79), absenceBorderColor: Color = Color(hex: 0x00A3FF), normalBorderColor: Color = .white) {
        self.normalTextColor = normalTextColor
        self.selectedTextColor = selectedTextColor
        self.weekdayTextColor = weekdayTextColor
        self.pickerTextColor = pickerTextColor
        self.holidayTextColor = holidayTextColor
        self.absenceTextColor = absenceTextColor
        self.backgroundColor = backgroundColor
        self.absenceBackColor = absenceBackColor
        self.selectedBackColor = selectedBackColor
        self.betweenBackColor = betweenBackColor
        self.holidayBackColor = holidayBackColor
        self.pickerBackColor = pickerBackColor
        self.holidayBorderColor = holidayBorderColor
        self.absenceBorderColor = absenceBorderColor
        self.normalBorderColor = normalBorderColor
    }
}
