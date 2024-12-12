// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 16.0, *)
public struct CustomCalendar: View {
    @StateObject var manager: CalenderManager
    
    @Binding var monthOffset: Int
    @Binding var isPickerPresented: Bool
    @Binding var isLoading: Bool
    @Binding var currentDate: Date
    @Binding var selectedDates: [Date]
    @Binding var eventList: [Event]
    
    private var enableHorizontalScroll: Bool
    
    public init(monthOffset: Binding<Int>, isPickerPresented: Binding<Bool>, isLoading: Binding<Bool>, currentDate: Binding<Date>, selectedDates: Binding<[Date]>, eventList: Binding<[Event]>, colors: Colors = Colors(), disableBeforeTodayDates: Bool = true, calendarType: CalendarType = .calendarOne, enableHorizontalScroll: Bool = false) {
        _monthOffset = monthOffset
        _isPickerPresented = isPickerPresented
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
            VStack(alignment: .leading, spacing: 16) {
                
                MonthHeader(manager: manager, monthOffset: $monthOffset, isPickerPresented: $isPickerPresented)
                
                Weekday(manager: manager)
                
                Month(manager: manager, isLoading: $isLoading, monthOffset: monthOffset)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            }
            .onChange(of: monthOffset) { offset in
                manager.updateCurrentDate(monthOffset: offset)
                currentDate = manager.currentDate
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

#Preview {
    CustomCalendar(monthOffset: .constant(0), isPickerPresented: .constant(false), isLoading: .constant(true), currentDate: .constant(Date()), selectedDates: .constant([]), eventList: .constant([]))
}
