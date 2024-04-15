//
//  AppSettings.swift
//  Shift
//
//  Created by Espen Scheuer on 4/14/24.
//

import SwiftUI

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    @AppStorage("creativePursuitsEnabled") var creativePursuitsEnabled = true
    @AppStorage("outdoorActivitiesEnabled") var outdoorActivitiesEnabled = true
    @AppStorage("healthAndWellnessEnabled") var healthAndWellnessEnabled = true
    @AppStorage("socialActivitiesEnabled") var socialActivitiesEnabled = true
    @AppStorage("selfImprovementEnabled") var selfImprovementEnabled = true
}
