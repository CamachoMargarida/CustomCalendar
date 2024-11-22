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
                Divider()
                
                Text(calendarDate.getText())
                    .foregroundStyle(calendarDate.getTextColor())
                    .background(calendarDate.getBackColor())
                    .font(calendarDate.font)
                    .background(calendarDate.getBackColor())
                
                VStack(alignment: .center, spacing: 2) {
                    ForEach(calendarDate.events.indices.prefix(3), id: \.self) { index in
                        Text(calendarDate.events[index])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundStyle(calendarDate.manager.colors.eventTextColor)
                            .font(Fonts(customSize: 8).regularTextFont)
                            .background(calendarDate.manager.colors.eventBackColor)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                    
                    if calendarDate.events.count > 3 {
                        Text("+\(calendarDate.events.count - 3)")
                            .frame(maxWidth: .infinity, maxHeight: calendarDate.events.count == 1 ? .infinity : nil)
                            .foregroundStyle(calendarDate.manager.colors.eventTextColor)
                            .font(Fonts(customSize: 8).regularTextFont)
                            .background(calendarDate.manager.colors.eventBackColor)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(2)
            }
            .frame(width: cellSize * 1.5, height: cellSize * 2.2)
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
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida","Catarina"]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida","Catarina","João R"]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida","Catarina","João R","João L"]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida","Catarina","João R","João L","Eduardo"]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: ["Margarida","Catarina","João R","João L","Eduardo","Tiago"]
            ),
            cellSize: 32
        )
    }
}
