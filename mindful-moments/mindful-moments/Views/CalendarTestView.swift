//
//  CalendarTest.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 3/26/24.
//

import SwiftUI

struct CalendarTestView: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .padding()
            
            // Date Picker
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(CalendarDatePickerStyle(selectedDate: $selectedDate))
                .padding()
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

struct CalendarDatePickerStyle: DatePickerStyle {
    @Binding var selectedDate: Date

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration
                .label
                .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: {
                selectedDate = Date()
            }) {
                Image(systemName: "calendar.today")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.secondary))
        .padding()
    }
}



struct CalendarDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTestView()
    }
}

