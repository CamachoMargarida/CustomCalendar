//
//  MonthYearPicker.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 05/11/2024.
//
import SwiftUI

struct MonthYearPicker: View {
    var manager: CalenderManager
    
    @Binding var monthOffset: Int
    @Binding var isPresented: Bool
    
    @State private var selectedMonth = Calendar.current.component(.month, from: Date()) - 1
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    
    let yearsRange: [String] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(currentYear...(currentYear + 2)).map { String($0) }
    }()
    let months = Calendar.current.monthSymbols
    
    var body: some View {
        // Pickers
        VStack {
            HStack(spacing: 0) {
                Picker("", selection: $selectedMonth) {
                    ForEach(0..<months.count, id: \.self) { month in
                        Text(months[month]).tag(month)
                            .foregroundStyle(manager.colors.pickerTextColor)
                    }
                }
                .pickerStyle(.wheel)
                .clipShape(.rect.offset(x: -16))
                .padding(.trailing, -16)
                
                Picker("", selection: $selectedYear) {
                    ForEach(yearsRange, id: \.self) { year in
                        Text("\(year)").tag(year)
                            .foregroundStyle(manager.colors.pickerTextColor)
                    }
                }
                .pickerStyle(.wheel)
                .clipShape(.rect.offset(x: 16))
                .padding(.leading, -16)
            }
        }
        .background(manager.colors.pickerBackColor)
        .frame(maxWidth: 300)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 10)
        .transition(.scale)
        .animation(.easeInOut, value: isPresented)
        .onAppear {
            let currentDate = Calendar.current.date(byAdding: .month, value: monthOffset, to: firstDateMonth()) ?? Date()
            selectedMonth = Calendar.current.component(.month, from: currentDate) - 1
            selectedYear = Calendar.current.component(.year, from: currentDate)
        }
        .onChange(of: isPresented) { newValue in
            if newValue == false {
                updateMonthOffset()
            }
        }
    }
    
    private func updateMonthOffset() {
        let yearDiff = selectedYear - Calendar.current.component(.year, from: firstDateMonth())
        let monthDiff = selectedMonth - (Calendar.current.component(.month, from: firstDateMonth()) - 1)
        monthOffset = (yearDiff * 12) + monthDiff
    }
    
    private func firstDateMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }
}
