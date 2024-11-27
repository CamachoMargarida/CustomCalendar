// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 16.0, *)
public struct CustomCalendar: View {
    @StateObject var manager: CalenderManager
    @State var monthOffset = 0
    @State private var isPickerPresented = false
    
    @Binding var disabledList: [Date]
    @Binding var holidayList: [Date]
    @Binding var currentDate: Date
    @Binding var selectedDates: [Date]
    @Binding var eventList: [Event]
    
    public init(disabledList: Binding<[Date]>, holidayList: Binding<[Date]>, currentDate: Binding<Date>, selectedDates: Binding<[Date]>, eventList: Binding<[Event]>, colors: Colors = Colors(), disableBeforeTodayDates: Bool = true, calendarType: CalendarType = .calendarOne) {
        _disabledList = disabledList
        _holidayList = holidayList
        _currentDate = currentDate
        _selectedDates = selectedDates
        _eventList = eventList
        
        _manager = StateObject(wrappedValue: CalenderManager(
            colors: colors,
            calendar: Calendar.current,
            minimumDate: Date(),
            maximumDate: Calendar.current.date(byAdding: .month, value: 2, to: Date())!,
            disableBeforeTodayDates: disableBeforeTodayDates,
            calendarType: calendarType
        ))
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 16) {
                
                MonthHeader(manager: manager, monthOffset: $monthOffset, isPickerPresented: $isPickerPresented)
                
                Weekday(manager: manager)
                
                Month(manager: manager, monthOffset: monthOffset)
            }
            .onChange(of: monthOffset) { offset in
                manager.updateCurrentDate(monthOffset: offset)
                currentDate = manager.currentDate
            }
            .onChange(of: disabledList) { newList in
                manager.disabledDates.removeAll()
                manager.disabledDates = newList
            }
            .onChange(of: holidayList) { newList in
                manager.holidays.removeAll()
                manager.holidays = newList
            }
            .onChange(of: eventList) { newList in
                manager.events.removeAll()
                manager.events = newList
            }
            .onChange(of: manager.selectedDates) { newList in
                selectedDates = newList
            }

        }
        .background(manager.colors.backgroundColor)
        .overlay {
            if isPickerPresented {
                MonthYearPicker(manager: manager, monthOffset: $monthOffset, isPresented: $isPickerPresented)
            }
        }
    }
}
