    //
    //  SettingsView.swift
    //  Shift
    //
    //  Created by Espen Scheuer on 4/14/24.
    //

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settings = AppSettings.shared

    var body: some View {
            VStack {
                List {
                    Section(header: Text("Preferences")) {
                        // Add general settings here
                        Toggle("Creative Pursuits", isOn: $settings.creativePursuitsEnabled).tint(.black)
                        Toggle("Outdoor Activities", isOn: $settings.outdoorActivitiesEnabled).tint(.black)
                        Toggle("Health and Wellness", isOn: $settings.healthAndWellnessEnabled).tint(.black)
                        Toggle("Social Activities", isOn: $settings.socialActivitiesEnabled).tint(.black)
                        Toggle("Self Improvement", isOn: $settings.selfImprovementEnabled).tint(.black)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Settings")
            }
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
