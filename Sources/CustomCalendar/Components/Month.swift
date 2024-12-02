//
//  Month.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 03/11/2024.
//
import SwiftUI

struct Month: View {
    @State var isStartDate = true
    @ObservedObject var manager: CalenderManager
    
    @Binding var isLoading: Bool
    
    let monthOffset: Int
    let daysPerWeek = 7
    let cellSize: CGFloat = 32
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    var monthsArray: [[Date]] {
        monthArray()
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                }
                
                else {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(monthsArray, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { cell in
                                    cellView(cell)
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(manager.colors.backgroundColor)
    }
}

#Preview {
    Month(isStartDate: true, manager: CalenderManager(calendarType: .calendarTwo), isLoading: .constant(true), monthOffset: 0)
}
