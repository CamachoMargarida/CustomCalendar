//
//  CalendarDate.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

struct CalendarDate {
    var date: Date
    var manager: CalenderManager
    var isDisabled = false
    var isToday = false
    var isSelected = false
    var isBetween = false
    var isweekend = false
    var endDate: Date?
    var startDate: Date?
    
    init(date: Date, manager: CalenderManager, isDisabled: Bool = false, isToday: Bool = false, isSelected: Bool = false, isBetween: Bool = false, isweekend: Bool = false, endDate: Date? = nil, startDate: Date? = nil) {
        self.date = date
        self.manager = manager
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
        self.isBetween = isBetween
        self.isweekend = isweekend
        self.endDate = endDate
        self.startDate = startDate
    }
    
    var isEndDate: Bool {
        date == endDate
    }
    
    var isStartDate: Bool {
        date == startDate
    }
    
    var font: Font {
        if isSelected { return manager.fonts.selectedTextFont }
        
        return manager.fonts.regularTextFont
    }
    
    func getText() -> String {
        let day = Settings.formatDate(date: date)
        return day
    }
    
    func getTextColor() -> Color {
        if isSelected || isToday { return manager.colors.selectedTextColor }
        else if isweekend { return manager.colors.weekdayTextColor }
        
        return manager.colors.normalTextColor
    }
    
    func getBackColor() -> Color {
        if isSelected { return manager.colors.selectedBackColor }
        else if isDisabled { return manager.colors.disabledBackColor }
        else if isBetween { return manager.colors.betweenBackColor }
        
        return manager.colors.backgroundColor
    }
    
    func getBorderColor() -> Color {
        if isDisabled { return manager.colors.disabledBorderColor }
        
        return manager.colors.normalBorderColor
    }
    
    func getBorderShape() -> some Shape {
        if isSelected || isBetween { return AnyShape(Circle()) }
        
        return AnyShape(RoundedRectangle(cornerRadius: 8))
    }
}
