//
//  Event.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 21/11/2024.
//
import SwiftUI

public struct Event: Identifiable, Equatable {
    public var id: Int
    var title: String
    var date: Date
    
    public init(id: Int, title: String, date: Date) {
        self.id = id
        self.title = title
        self.date = date
    }
}
