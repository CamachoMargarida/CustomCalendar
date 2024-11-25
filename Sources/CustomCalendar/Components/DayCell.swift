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
                .clipShape(calendarDate.getBorderShape())
                .overlay {
                    calendarDate.getBorderShape()
                        .stroke(calendarDate.getBorderColor(), lineWidth: 1)
                }
                .frame(maxWidth: .infinity, alignment: .center)
        }
        else {
            VStack(spacing: 0) {
                Divider()
                
                Text(calendarDate.getText())
                    .foregroundStyle(calendarDate.getTextColor())
                    .background(calendarDate.getBackColor())
                    .font(calendarDate.font)
                    .strikethrough(calendarDate.isBeforeToday, color: calendarDate.getTextColor())
                
                ScrollView(.vertical) {
                    VStack(alignment: .center, spacing: 2) {
                        ForEach(calendarDate.events, id: \.id) { event in
                            Text(event.title)
                                .frame(maxWidth: .infinity, maxHeight: event.title == "Feriado" ? cellSize * 2.2 : nil)
                                .foregroundStyle(event.style.textColor)
                                .font(Fonts(customSize: 8).regularTextFont)
                                .background(event.style.backgroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: 2))
                                .overlay {
                                    event.style.borderStyle
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        /*ForEach(calendarDate.events.prefix(3), id: \.id) { event in
                         Text(event.title)
                         .frame(maxWidth: .infinity, maxHeight: event.title == "Feriado" ? .infinity : nil)
                         .foregroundStyle(event.style.textColor)
                         .font(Fonts(customSize: 8).regularTextFont)
                         .background(event.style.backgroundColor)
                         .clipShape(RoundedRectangle(cornerRadius: 2))
                         .overlay {
                         event.style.borderStyle
                         }
                         .frame(maxWidth: .infinity, alignment: .center)
                         }
                         
                         if calendarDate.events.count > 3 {
                         Text("+\(calendarDate.events.count - 3)")
                         .frame(maxWidth: .infinity)
                         .foregroundStyle(calendarDate.events.last!.style.textColor)
                         .font(Fonts(customSize: 8).regularTextFont)
                         .background(calendarDate.events.last!.style.backgroundColor)
                         .clipShape(RoundedRectangle(cornerRadius: 2))
                         .overlay {
                         calendarDate.events.last!.style.borderStyle
                         }
                         .frame(maxWidth: .infinity, alignment: .center)
                         }*/
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(2)
                }
            }
            .frame(width: cellSize * 1.5, height: cellSize * 2.2)
        }
    }
}

/*#Preview {
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
                events: [
                    Event(
                        title: "Margarida",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "Catarina",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "João R",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "João L",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "Eduardo",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "Tiago",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "Alexandre",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    )
                ]
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
                events: [Event(
                    title: "Margarida",
                    date: Date(),
                    style: EventStyle(
                        backgroundColor: .white,
                        textColor: .orange,
                        borderColor: .orange,
                        borderStyle: AnyShape(
                            RoundedRectangle(cornerRadius: 2)
                                .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                        )
                    )
                )]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: [
                    Event(
                        title: "Margarida",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .orange,
                            borderColor: .orange,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                            )
                        )
                    ),
                    Event(
                        title: "Catarina",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .orange,
                            borderColor: .orange,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                            )
                        )
                    )
                ]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: [
                    Event(
                        title: "Margarida",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .orange,
                            borderColor: .orange,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                            )
                        )
                    ),
                    Event(
                        title: "Catarina",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .orange,
                            borderColor: .orange,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                            )
                        )
                    ),
                    Event(
                        title: "João R",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .red,
                            borderColor: .red,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.red, lineWidth: 1)
                            )
                        )
                    )
                ]
            ),
            cellSize: 32
        )
        DayCell(
            calendarDate: CalendarDate(
                date: Date(),
                manager: CalenderManager(calendarType: .calendarTwo),
                events: [
                    Event(
                        title: "Margarida",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .orange,
                            borderColor: .orange,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                            )
                        )
                    ),
                    Event(
                        title: "Catarina",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .orange,
                            borderColor: .orange,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .strokeBorder(.orange, style: StrokeStyle(lineWidth: 1, dash: [3]))
                            )
                        )
                    ),
                    Event(
                        title: "João R",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .red,
                            borderColor: .red,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.red, lineWidth: 1)
                            )
                        )
                    ),
                    Event(
                        title: "João L",
                        date: Date(),
                        style: EventStyle(
                            backgroundColor: .white,
                            textColor: .green,
                            borderColor: .green,
                            borderStyle: AnyShape(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(.green, lineWidth: 1)
                            )
                        )
                    )
                ]
            ),
            cellSize: 32
        )
    }
}
*/
