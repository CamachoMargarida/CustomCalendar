//
//  MonthHeader.swift
//  CustomCalendar
//
//  Created by Margarida Camacho on 04/11/2024.
//
import SwiftUI

struct MonthHeader: View {
    var manager: CalenderManager
    @Binding var monthOffset: Int
    @Binding var isPickerPresented: Bool
    
    var body: some View {
        HStack {
            Text(manager.monthHeader())
                .font(manager.fonts.headerTextFont)
                .foregroundStyle(manager.colors.normalTextColor)
            
            Image(.arrowRight)
                .foregroundStyle(manager.colors.selectedTextColor)
            
            Spacer()
        }
        .onTapGesture {
            isPickerPresented = true
        }
    }
}
