//
//  Event.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 21/11/2024.
//
import SwiftUI

public struct Event: Identifiable, Equatable {
    public var id: Int?
    var title: String?
    var date: Date?
    
    init(id: Int? = nil, title: String? = nil, date: Date? = nil) {
        self.id = id
        self.title = title
        self.date = date
    }
}
