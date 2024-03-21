//
//  CalendarView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/26/24.
//

import SwiftUI

struct CalendarView: View {
    
//    State variable of type Date that updates when user selects from the date picker
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            VStack{
                //Calendar for user to pick a specifc date
                //Date gets saved into selectedDate variable which is type Date
                //Date picker style changes the laylout
                DatePicker(selection: $selectedDate, label: { Text("Select Date") })
                    .padding(.horizontal)
                    .datePickerStyle(.graphical)
            }
            .padding(.top)
            Spacer()
        }
    }
}

#Preview {
    CalendarView()
}
