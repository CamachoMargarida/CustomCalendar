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
        if calendarDate.manager.calendarType == .calendarOne {
            Text(calendarDate.getText())
                .frame(width: cellSize, height: cellSize)
                .foregroundStyle(calendarDate.getTextColor())
                .font(calendarDate.font)
                .background(calendarDate.getBackColor())
                .frame(maxWidth: .infinity, alignment: .center)
        }
        else {
            VStack(spacing: 0) {
                Text(calendarDate.getText())
                    .foregroundStyle(calendarDate.getTextColor())
                    .background(calendarDate.getBackColor())
                    .font(calendarDate.font)
                    .background(calendarDate.getBackColor())
                
                VStack(alignment: .center, spacing: 2) {
                    ForEach(calendarDate.events.indices.prefix(4), id: \.self) { index in
                        Text(calendarDate.events[index])
                            .frame(maxWidth: .infinity, maxHeight: calendarDate.events.count == 1 ? .infinity : nil)
                            .foregroundStyle(calendarDate.manager.colors.eventTextColor)
                            .font(Fonts(customSize: 10).regularTextFont)
                            .background(calendarDate.manager.colors.eventBackColor)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                    
                    if calendarDate.events.count > 4 {
                        Text("+\(calendarDate.events.count - 4)")
                            .frame(maxWidth: .infinity, maxHeight: calendarDate.events.count == 1 ? .infinity : nil)
                            .foregroundStyle(calendarDate.manager.colors.eventTextColor)
                            .font(Fonts(customSize: 10).regularTextFont)
                            .background(calendarDate.manager.colors.eventBackColor)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .border(.black, width: 1)
                .padding(2)
            }
            .frame(maxWidth: cellSize * 2, maxHeight: cellSize * 3)
            .border(.black, width: 1)
        }
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
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(),
                isWeekend: true
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida","Catarina","João R","João L","Eduardo","Tiago","Alexandre"]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo)
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida"]
            ),
            cellSize: 32
        )
    }
}
