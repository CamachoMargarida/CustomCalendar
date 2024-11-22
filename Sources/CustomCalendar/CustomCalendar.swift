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
            .onAppear {
                manager.events.removeAll()
                manager.disabledDates.removeAll()
                manager.holidays.removeAll()
                
                manager.events = eventList
                manager.disabledDates = disabledList
                manager.holidays = holidayList
                manager.currentDate = currentDate
                
                manager.objectWillChange.send()
            }
            .onChange(of: monthOffset) { _ in
                manager.updateCurrentDate()
            }
            .onChange(of: manager.selectedDates) { newList in
                selectedDates = newList
            }
            
            if isPickerPresented {
                manager.colors.backgroundColor.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPickerPresented = false
                    }
                
                MonthYearPicker(manager: manager, monthOffset: $monthOffset, isPresented: $isPickerPresented)
                    .frame(maxWidth: 300)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 10)
                    .transition(.scale)
                    .animation(.easeInOut, value: isPickerPresented)
            }
        }
        .background(manager.colors.backgroundColor)
    }
}
