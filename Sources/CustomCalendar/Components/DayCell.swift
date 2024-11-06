//
//  DayCell.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 01/11/2024.
//
import SwiftUI

struct DayCell: View {
    var calendarDate: CalendarDate
    var cellSize: CGFloat
    
    var body: some View {
        Text(calendarDate.getText())
            .frame(width: cellSize, height: cellSize)
            .foregroundStyle(calendarDate.getTextColor())
            .font(calendarDate.font)
            .background(calendarDate.getBackColor())
            .clipShape(calendarDate.getBorderShape())
            .overlay {
                calendarDate.getBorderShape()
                    .stroke(calendarDate.getBorderColor(), lineWidth: 1)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        
    }
}

#Preview {
    Group {
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(),
                isDisabled: true
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(),
                isToday: true
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(),
                isSelected: true
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(),
                isBetween: true
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager()
            ),
            cellSize: 32
        )
    }
}
