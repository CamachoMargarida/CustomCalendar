//
//  CalenderManager.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

class CalenderManager: ObservableObject {
    @Published var selectedDate: Date? = nil
    @Published var disabledDates: [Date] = []
    @Published var holidays: [Date] = []
    @Published var events: [Event] = []
    @Published public var colors: Colors
    @Published var disableBeforeTodayDates: Bool
    @Published var selectedDates: [Date] = []
    
    @Published var startDate: Date? = nil {
        didSet {
            updateSelectedDates()
        }
    }
    @Published var endDate: Date? = nil {
        didSet {
            updateSelectedDates()
        }
    }
    
    public var calendarType: CalendarType
    
    var calendar = Calendar.current
    var minimumDate = Date()
    var maximumDate = Date()
    var disabledAfterDate: Date?
    var fonts = Fonts()
    var currentDate: Date
    
    init(selectedDate: Date? = nil, startDate: Date? = nil, endDate: Date? = nil, colors: Colors = Colors(), calendar: Foundation.Calendar = Calendar.current, minimumDate: Date = Date(), maximumDate: Date = Date(), disabledAfterDate: Date? = nil, disableBeforeTodayDates: Bool = true, calendarType: CalendarType = .calendarOne) {
        self.selectedDate = selectedDate
        self.startDate = startDate
        self.endDate = endDate
        self.colors = colors
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.disabledAfterDate = disabledAfterDate
        self.disableBeforeTodayDates = disableBeforeTodayDates
        
        self.currentDate = minimumDate
        self.calendarType = calendarType
        
        updateSelectedDates()
    }
    
    func disabledDatesContains(date: Date) -> Bool {
        if let disabledAfterDate = disabledAfterDate, date > disabledAfterDate {
            return true
        }
        else {
            return disabledDates.contains { disabledDate in
                
                calendar.isDate(disabledDate, inSameDayAs: date)
            }
        }
    }
    
    func holidaysContains(date: Date) -> Bool {
        return holidays.contains { holiday in
            
            calendar.isDate(holiday, inSameDayAs: date)
        }
    }
    
    func firstDateMonth() -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: minimumDate)
        components.day = 1
        
        return calendar.startOfDay(for: calendar.date(from: components) ?? Date())
    }
    
    func firstOfMonthForOffset(_ offset: Int) -> Date? {
        var offsetComponent = DateComponents()
        offsetComponent.month = offset
        
        return calendar.startOfDay(for: calendar.date(byAdding: offsetComponent, to: firstDateMonth())!)
    }
    
    func monthHeader() -> String {
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        return "\(calendar.monthSymbols[month - 1]) \(year)"
    }
    
    func updateCurrentDate(monthOffset: Int) {
        currentDate = calendar.startOfDay(for: calendar.date(byAdding: .month, value: monthOffset, to: Date())!)
        
        minimumDate = calendar.startOfDay(for: calendar.date(byAdding: .month, value: -1, to: currentDate)!)
        maximumDate = calendar.startOfDay(for: calendar.date(byAdding: .month, value: 2, to: currentDate)!)
    }
    
    func updateSelectedDates() {
        selectedDates.removeAll()
        
        if let startDate = startDate {
            var currentDate = startDate
            
            if let endDate = endDate {
                while currentDate <= endDate {
                    if !calendar.isDateInWeekend(currentDate) && !disabledDatesContains(date: currentDate) && !holidaysContains(date: currentDate) {
                        selectedDates.append(currentDate)
                    }
                    currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                }
            }
            
            else {
                if !calendar.isDateInWeekend(currentDate) && !disabledDatesContains(date: currentDate) && !holidaysContains(date: currentDate) {
                    selectedDates.append(currentDate)
                }
            }
        }
    }
}
