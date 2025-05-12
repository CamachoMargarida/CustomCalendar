//
//  PartialCalendar.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 12/05/2025.
//
import SwiftUI

@available(iOS 16.0, *)
public struct PartialCalendar: View {
    @StateObject var manager: CalenderManager
    
    @Binding var selectedDates: [Date]
    
    public init(selectedDates: Binding<[Date]>, colors: Colors = Colors()) {
        _selectedDates = selectedDates
        
        _manager = StateObject(wrappedValue: CalenderManager(
            colors: colors,
            calendar: Calendar.current,
            calendarType: .partialCalendar
        ))
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Weekday(manager: manager)
            
            Month(manager: manager, isLoading: .constant(false), monthOffset: 0) //Offset ignored ao partial calendar
        }
        .onAppear { manager.selectedDates = selectedDates }
        .onChange(of: manager.selectedDates) { newList in
            selectedDates = newList
        }
        .onChange(of: selectedDates) { newDates in
            manager.selectedDates = newDates
        }
    }
}

#Preview {
    PartialCalendar(
        selectedDates: .constant(datesBetween(start: "2025-05-07", end: "2025-05-12")),
    )
}

func datesBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> [Date] {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = .current
    
    guard let startDate = formatter.date(from: start),
          let endDate = formatter.date(from: end) else { return [] }
    
    var dates: [Date] = []
    var current = Calendar.current.startOfDay(for: startDate)
    let endDay = Calendar.current.startOfDay(for: endDate)

    while current <= endDay {
        dates.append(current)
        current = Calendar.current.date(byAdding: .day, value: 1, to: current)!
    }

    return dates
}
