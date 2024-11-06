//
//  Settings.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

class Settings {
    static func getWeekdayHeaders(calendar: Calendar) -> [String] {
        let weekdays = calendar.shortStandaloneWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday
        
        return Array(weekdays[firstWeekdayIndex...] + weekdays[..<firstWeekdayIndex])
    }
    
    static func formatDate(date: Date) -> String {
        return date.formatted(.dateTime.day())
    }
    
    static func stringFromDate(date: Date) -> String {
        return date.formatted()
    }
    
    static func getMonthDayFromDate(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        
        return components.month! - 1
    }
    
    static func getMonthHeader(date: Date) -> String {
        let dateStyle = Date.FormatStyle()
            .year(.defaultDigits)
            .month(.wide)
        
        return date.formatted(dateStyle)
    }
    
    static func numberOfMonths(_ minDate: Date, _ maxDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.month], from: minDate, to: maxDate)
        
        return components.month! + 1
    }
    
    static func lasDayOfMonth(date: Date, calendar: Calendar = .current) -> Date {
        var components = calendar.dateComponents([.year, .month], from: date)
        components.setValue(1, for: .day)
        
        guard let startOfMonth = calendar.date(from: components) else {
            fatalError("Invalid Date Components")
        }
        
        return calendar.date(byAdding: .month, value: 1, to: startOfMonth)?.addingTimeInterval(-86500) ?? startOfMonth
    }
    
    static func getDayBorderShape(isSelected: Bool) -> some Shape {
        if isSelected { return AnyShape(Circle()) }
        
        return AnyShape(RoundedRectangle(cornerRadius: 8))
    }
}
