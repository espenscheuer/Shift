//
//  CalendarView.swift
//  Shift
//
//  Created by Espen Scheuer on 4/14/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
        var body: some View {
            
            VStack {
                
                Spacer()
                Spacer()
                
                Text("The activity you did on this day and some more text.")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .navigationBarTitle("Calendar")
                
                Spacer()
                
            }
            
        }
    }
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
