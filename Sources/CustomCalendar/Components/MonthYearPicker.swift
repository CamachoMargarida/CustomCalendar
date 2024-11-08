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
    
    let yearsRange = Array(2023...2030)
    let months = Calendar.current.monthSymbols
    
    var body: some View {
        HStack {
            Picker("", selection: $selectedMonth) {
                ForEach(0..<months.count, id: \.self) { month in
                    Text(months[month]).tag(month)
                        .foregroundStyle(manager.colors.pickerTextColor)
                }
            }
            .pickerStyle(.wheel)
            
            Picker("", selection: $selectedYear) {
                ForEach(yearsRange, id: \.self) { year in
                    Text("\(year)").tag(year)
                        .foregroundStyle(manager.colors.pickerTextColor)
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
        }
        .onAppear {
            let currentDate = Calendar.current.date(byAdding: .month, value: monthOffset, to: firstDateMonth()) ?? Date()
            selectedMonth = Calendar.current.component(.month, from: currentDate) - 1
            selectedYear = Calendar.current.component(.year, from: currentDate)
        }
        .onTapGesture {
            isPresented = false
        }
        .onChange(of: selectedMonth) { _ in  updateMonthOffset() }
        .onChange(of: selectedYear) { _ in updateMonthOffset() }
        .background(manager.colors.pickerBackColor)
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
