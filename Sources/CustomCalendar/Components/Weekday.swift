//
//  Weekday.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 03/11/2024.
//
import SwiftUI

struct Weekday: View {
    var manager: CalenderManager
    var weekdays: [String] {
        Settings.getWeekdayHeaders(calendar: manager.calendar)
    }
    var body: some View {
        HStack(alignment: .center) {
            ForEach(weekdays, id: \.self) { weekday in
                Text(weekday)
                    .font(manager.fonts.regularTextFont)
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(manager.colors.weekdayTextColor)
            .background(manager.colors.backgroundColor)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    Weekday(manager: CalenderManager())
}
