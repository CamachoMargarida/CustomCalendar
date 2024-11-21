//
//  Extensions.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 03/11/2024.
//
import SwiftUI

// MARK: Month Extensions
extension Month {
    func firstDateMonth() -> Date {
        var components = manager.calendar.dateComponents(calendarUnitYMD, from: Date())
        components.day = 1
        
        return manager.calendar.date(from: components)!
    }
    
    func firstOfMonthOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return manager.calendar.date(byAdding: offset, to: firstDateMonth())!
    }
    
    func isThisMonth(date: Date) -> Bool {
        return manager.calendar.isDate(date, equalTo: firstOfMonthOffset(), toGranularity: .month)
    }
    
    func formatDate(date: Date) -> Date {
        let components = manager.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return manager.calendar.date(from: components)!
    }
    
    func formatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = formatDate(date: referenceDate)
        let clampedDate = formatDate(date: date)
        
        return refDate == clampedDate
    }
    
    func numberOfDays(offset: Int) -> Int {
        let firstOfMonth = firstOfMonthOffset()
        let rangeOfWeeks = manager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        return (rangeOfWeeks?.count)! * daysPerWeek
    }
    
    func isStartDate(date: Date) -> Bool {
        if manager.startDate == nil { return false }
        
        return formatAndCompareDate(date: date, referenceDate: manager.startDate ?? Date())
    }
    
    func isEndDate(date: Date) -> Bool {
        if manager.endDate == nil { return false }
        
        return formatAndCompareDate(date: date, referenceDate: manager.endDate ?? Date())
    }
    
    func isBetweenDate(date: Date) -> Bool {
        if manager.startDate == nil { return false }
        else if manager.endDate == nil { return false }
        else if manager.calendar.compare(date, to: manager.startDate ?? Date(), toGranularity: .day) == .orderedAscending { return false }
        else if manager.calendar.compare(date, to: manager.endDate ?? Date(), toGranularity: .day) == .orderedDescending { return false }
        
        return !isWeekendDate(date: date) && !isHoliday(date: date) && isEnabled(date: date)
    }
    
    func isEnabled(date: Date) -> Bool {
        if manager.disableBeforeTodayDates {
            return !isAbsence(date: date) && !isHoliday(date: date) && !isBeforeToday(date: date) && !isWeekendDate(date: date)
        }
        return !isAbsence(date: date) && !isHoliday(date: date) && !isWeekendDate(date: date)
    }
    
    func isAbsence(date: Date) -> Bool {
        return manager.disabledDates.contains(date)
    }
    
    func isHoliday(date: Date) -> Bool {
        return manager.holidays.contains(date)
    }
    
    func isStartDateAfterEnd() -> Bool {
        if manager.startDate == nil { return false }
        else if manager.endDate == nil { return false }
        else if manager.calendar.compare(manager.endDate ?? Date(), to: manager.startDate ?? Date(), toGranularity: .day) == .orderedDescending { return false }
        
        return true
    }
    
    func isAfterStart(date: Date) -> Bool {
        if manager.startDate == nil { return false }
        
        return manager.calendar.compare(manager.startDate ?? Date(), to: date, toGranularity: .day) == .orderedAscending
    }
    
    func isBeforeToday(date: Date) -> Bool {
        return manager.calendar.compare(Date(), to: date, toGranularity: .day) == .orderedDescending
    }
    
    func isToday(date: Date) -> Bool {
        return formatAndCompareDate(date: date, referenceDate: Date())
    }
    
    func isSelectedDate(date: Date) -> Bool {
        if manager.selectedDate == nil { return false }
        
        return formatAndCompareDate(date: date, referenceDate: manager.selectedDate ?? Date())
    }
    
    func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date) || isStartDate(date: date) || isEndDate(date: date)
        
    }
    
    func isWeekendDate(date: Date) -> Bool {
        return manager.calendar.isDateInWeekend(date)
    }
    
    func dateEvents(date: Date) -> [String] {
        return manager.events.map { $0.title }
    }
    
    func dateTapped(date: Date) {
        if isEnabled(date: date) {
            if isAfterStart(date: date) { isStartDate = false }
            
            if isStartDate {
                manager.startDate = date
                manager.endDate = nil
                isStartDate = false
            }
            
            else {
                manager.endDate = date
                
                if isStartDateAfterEnd() {
                    manager.endDate = nil
                    manager.startDate = nil
                }
                
                isStartDate = true
            }
        }
    }
    
    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthOffset()
        let weekday = manager.calendar.component(.weekday, from: firstOfMonth)
        
        var startOffset = weekday - manager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        
        var components = DateComponents()
        components.day = index - startOffset
        
        return manager.calendar.date(byAdding: components, to: firstOfMonth)!
    }
    
    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        
        for row in 0..<(numberOfDays(offset: monthOffset) / daysPerWeek) {
            var columnArray = [Date]()
            
            for column in 0...(daysPerWeek - 1) {
                let cell = getDateAtIndex(index: (row * daysPerWeek) + column)
                columnArray.append(cell)
            }
            
            rowArray.append(columnArray)
        }
        
        return rowArray
    }
    
    func getMonthHeader() -> String {
        Settings.getMonthHeader(date: firstOfMonthOffset())
    }
    
    func cellView(_ date: Date) -> some View {
        HStack(spacing: 0) {
            if isThisMonth(date: date) {
                if manager.calendarType == .calendarOne {
                    DayCell(
                        calendarDate: CalendarDate(
                            date: date,
                            manager: manager,
                            isDisabled: isAbsence(date: date),
                            isToday: isToday(date: date),
                            isSelected: isSpecialDate(date: date),
                            isBetween: isBetweenDate(date: date),
                            isWeekend: isWeekendDate(date: date),
                            isHoliday: isHoliday(date: date),
                            endDate: manager.endDate,
                            startDate: manager.startDate
                        ),
                        cellSize: cellSize
                    )
                    .onTapGesture {
                        dateTapped(date: date)
                    }
                }
                else {
                    DayCell(
                        calendarDate: CalendarDate(
                            date: date,
                            manager: manager,
                            events: dateEvents(date: date)
                        ),
                        cellSize: cellSize
                    )
                }
            }
            
            else {
                Text("")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
