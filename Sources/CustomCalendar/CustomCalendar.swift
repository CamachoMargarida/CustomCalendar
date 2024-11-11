// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 16.0, *)
public struct CustomCalendar: View {
    @StateObject var manager = CalenderManager(
        calendar: Calendar.current,
        minimumDate: Date(),
        maximumDate: Calendar.current.date(byAdding: .month, value: 2, to: Date())!
    )
    @State var monthOffset = 0
    @State private var isPickerPresented = false
    
    @Binding var disabledList: [Date]
    @Binding var holidayList: [Date]
    @Binding var currentDate: Date
    @Binding var selectedDates: [Date]
    
    public init(disabledList: Binding<[Date]>, holidayList: Binding<[Date]>, currentDate: Binding<Date>, selectedDates: Binding<[Date]>, colors: Colors = Colors()) {
        _disabledList = disabledList
        _holidayList = holidayList
        _currentDate = currentDate
        _selectedDates = selectedDates
        manager.colors = colors
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 16) {
                
                MonthHeader(manager: manager, monthOffset: $monthOffset, isPickerPresented: $isPickerPresented)
                
                Weekday(manager: manager)
                
                Month(manager: manager, monthOffset: monthOffset)
            }
            .background(manager.colors.backgroundColor)
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
    }
}
