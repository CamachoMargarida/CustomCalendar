//
//  Event.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 21/11/2024.
//
import SwiftUI

public struct Event: Equatable {
    var id: Int?
    var title: String
    var date: Date
    var style: EventStyle
    
    public init(id: Int? = nil, title: String, date: Date, style: EventStyle) {
        self.id = id
        self.title = title
        self.date = date
        self.style = style
    }
}

public struct EventStyle: Equatable {
    public static func == (lhs: EventStyle, rhs: EventStyle) -> Bool {
        return lhs.backgroundColor == rhs.backgroundColor &&
            lhs.textColor == rhs.textColor &&
            lhs.borderColor == rhs.borderColor
    }
    
    var backgroundColor: Color
    var textColor: Color
    var borderColor: Color
    var borderStyle: RoundedRectangle
}
