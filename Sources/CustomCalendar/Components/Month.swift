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
    @Binding var monthOffset: Int
    let daysPerWeek = 7
    let cellSize: CGFloat = 32
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    var monthsArray: [[Date]] {
        monthArray()
    }
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 10) {
                
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
        .background(manager.colors.backgroundColor)
    }
}

struct ParentView: View {
    @State private var monthOffset: Int = 0
    
    var body: some View {
        Month(isStartDate: true, manager: CalenderManager(calendarType: .calendarTwo), monthOffset: $monthOffset)
    }
}
