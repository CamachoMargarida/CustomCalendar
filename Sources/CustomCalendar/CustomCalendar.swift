// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 16.0, *)
public struct CustomCalendar: View {
    @StateObject var manager: CalenderManager
    
    @Binding var monthOffset: Int
    @Binding var isPickerPresented: Bool
    @Binding var isLoading: Bool
    @Binding var disabledList: [Date]
    @Binding var holidayList: [Date]
    @Binding var currentDate: Date
    @Binding var selectedDates: [Date]
    @Binding var eventList: [Event]
    
    private var enableHorizontalScroll: Bool
    
    public init(monthOffset: Binding<Int>, isPickerPresented: Binding<Bool>, isLoading: Binding<Bool>, disabledList: Binding<[Date]>, holidayList: Binding<[Date]>, currentDate: Binding<Date>, selectedDates: Binding<[Date]>, eventList: Binding<[Event]>, colors: Colors = Colors(), disableBeforeTodayDates: Bool = true, calendarType: CalendarType = .calendarOne, enableHorizontalScroll: Bool = false) {
        _monthOffset = monthOffset
        _isPickerPresented = isPickerPresented
        _disabledList = disabledList
        _holidayList = holidayList
        _currentDate = currentDate
        _selectedDates = selectedDates
        _eventList = eventList
        _isLoading = isLoading
        
        _manager = StateObject(wrappedValue: CalenderManager(
            colors: colors,
            calendar: Calendar.current,
            minimumDate: Date(),
            maximumDate: Calendar.current.date(byAdding: .month, value: 2, to: Date())!,
            disableBeforeTodayDates: disableBeforeTodayDates,
            calendarType: calendarType
        ))
        
        self.enableHorizontalScroll = enableHorizontalScroll
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 16) {
                
                MonthHeader(manager: manager, monthOffset: $monthOffset, isPickerPresented: $isPickerPresented)
                
                Weekday(manager: manager)
                
                Month(manager: manager, monthOffset: monthOffset)
                    .opacity(isLoading ? 0 : 1)
                
                ProgressView()
                    .frame(maxHeight: .infinity, alignment: .center)
                    .opacity(isLoading ? 1 : 0)
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
        .gesture(enableHorizontalScroll ? drag : nil)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onEnded { value in
                withAnimation {
                    // Swipe right
                    if value.translation.width > 0 {
                        monthOffset -= 1
                    }
                    // Swipe left
                    else if value.translation.width < 0 {
                        monthOffset += 1
                    }
                }
            }
    }
}
