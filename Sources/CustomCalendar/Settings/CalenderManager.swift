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
    @Published var selectedDates: [Date] = []
    @Published public var colors: Colors
    
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
    
    var calendar = Calendar.current
    var minimumDate = Date()
    var maximumDate = Date()
    var disabledAfterDate: Date?
    var fonts = Fonts()
    var currentDate: Date
    
    init(selectedDate: Date? = nil, startDate: Date? = nil, endDate: Date? = nil, colors: Colors = Colors(), calendar: Foundation.Calendar = Calendar.current, minimumDate: Date = Date(), maximumDate: Date = Date(), disabledAfterDate: Date? = nil) {
        self.selectedDate = selectedDate
        self.startDate = startDate
        self.endDate = endDate
        self.colors = colors
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.disabledAfterDate = disabledAfterDate
        
        self.currentDate = minimumDate
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
    
    func firstDateMonth() -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: minimumDate)
        components.day = 1
        
        return calendar.date(from: components) ?? Date()
    }
    
    func firstOfMonthForOffset(_ offset: Int) -> Date? {
        var offsetComponent = DateComponents()
        offsetComponent.month = offset
        
        return calendar.date(byAdding: offsetComponent, to: firstDateMonth())
    }
    
    func monthHeader() -> String {
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        return "\(calendar.monthSymbols[month - 1]) \(year)"
    }
    
    func updateCurrentDate(monthOffset: Int) {
        currentDate = calendar.date(byAdding: .month, value: monthOffset, to: Date())!
        
        minimumDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
        maximumDate = calendar.date(byAdding: .month, value: 2, to: currentDate)!
    }
    
    func updateSelectedDates() {
        selectedDates.removeAll()
        
        guard let start = startDate, let end = endDate else { return }
        
        var currentDate = start
        while currentDate <= end {
            selectedDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
    }
}
