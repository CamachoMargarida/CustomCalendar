// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 18.0, *)
public struct CustomCalendar: View {
    @State var manager = CalenderManager(
        calendar: Calendar.current,
        minimumDate: Date(),
        maximumDate: Calendar.current.date(byAdding: .month, value: 2, to: Date())!
    )
    @State var monthOffset = 0
    @State private var isPickerPresented = false
    
    public var body: some View {
        ZStack {
            VStack(spacing: 16) {
                
                MonthHeader(manager: manager, monthOffset: $monthOffset, isPickerPresented: $isPickerPresented)
                
                Weekday(manager: manager)
                
                Month(manager: manager, monthOffset: monthOffset)
            }
            .padding()
            .background(manager.colors.backgroundColor)
            .onChange(of: monthOffset) {
                manager.updateCurrentDate(monthOffset: monthOffset)
            }
            
            if isPickerPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPickerPresented = false
                    }
                
                MonthYearPicker(monthOffset: $monthOffset, isPresented: $isPickerPresented)
                    .frame(maxWidth: 300)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 10)
                    .transition(.scale)
                    .animation(.easeInOut, value: isPickerPresented)
            }
        }
    }
}
