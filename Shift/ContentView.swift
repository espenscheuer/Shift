//
//  ContentView.swift
//  Shift
//
//  Created by Espen Scheuer on 4/13/24.
//

    import SwiftUI
    import UserNotifications

    struct ContentView: View {
        
        @ObservedObject var settings = AppSettings.shared
        
        @AppStorage("selectedActivity") private var selectedActivity: String?
        
        let dailyActivities: [[String: Any]] = [
            ["description": "During lunch, visit a nearby park and spend 10 minutes checking it out.",
             "tags": ["Outdoor activities"]],
            
            ["description": "At 3pm, spend 5 minutes doing deep breathing exercises.",
             "tags": ["Health and wellness"]],
            
            ["description": "Before bed, spend 20 minutes reading something you haven't read before.",
             "tags": ["Self improvement", "Creative pursuits"]],
            
            ["description": "As soon as you wake up, tidy up your bedroom for a fresh start to the day.",
             "tags": ["Self improvement"]],
            
            ["description": "Before dinner, spend 15 minutes tidying up your living space.",
             "tags": ["Self improvement"]],
            
            ["description": "Head to a park after work and say hi to a stranger.",
             "tags": ["Social activities"]],
            
            ["description": "In the afternoon, step outside for 10 minutes of sunlight exposure.",
             "tags": ["Outdoor activities", "Health and wellness"]],
            
            ["description": "Before dinner, spend 15 minutes tidying up your living space.",
             "tags": ["Self improvement"]],
            
            ["description": "After dinner, take a leisurely stroll around your neighborhood.",
             "tags": ["Outdoor activities"]],
            
            ["description": "Before bedtime, write down three things you're thankful for.",
             "tags": ["Health and wellness"]],
            
            ["description": "During your morning commute, listen to a brand new podcast.",
             "tags": ["Self improvement"]],
            
            ["description": "This evening, go out to a bar or restaurant you've never been to.",
             "tags": ["Social activities"]],
            
            ["description": "At 11am, text a friend you haven't talked to for a while.",
             "tags": ["Social activities"]],
            
            ["description": "Before bedtime, spend 10 minutes doing some yoga",
             "tags": ["Health and wellness"]],
            
            ["description": "On your way home this afternoon, get off transit a stop early and explore.",
             "tags": ["Outdoor activities"]],
            
            ["description": "At noon, spend 15 minutes drawing something that you see.",
             "tags": ["Creative pursuits"]],
            
            ["description": "Before bed, write down one thing you experienced today that made you proud or brought you joy.",
             "tags": ["Self improvement"]],
            
            ["description": "Find a nice spot to watch the sun set.",
             "tags": ["Outdoor activities"]],
            
            ["description": "At 7pm, write a short poem, try to make it rhyme!",
             "tags": ["Creative pursuits"]],
            
            ["description": "Try to take a beautiful photo of something you see everyday.",
             "tags": ["Creative pursuits", "Outdoor activities"]],
            
            ["description": "This evening, learn 5 new words in a different language and write them down.",
             "tags": ["Self improvement"]],
            
            ["description": "At 5:30pm, people-watch for 10 minutes and write down stories for the people you see.",
             "tags": ["Creative pursuits", "Social activities"]],
            
            ["description": "At 6pm, Learn how to make an origami frog.",
             "tags": ["Creative pursuits"]],
            
            ["description": "At 8pm, turn on dance music and clean your kitchen.",
             "tags": ["Self improvement"]],
            
            ["description": "This morning give a genuine complement to a stranger.",
             "tags": ["Social activities"]],
            
            ["description": "Leave your phone at home today!",
             "tags": ["Self improvement"]],
            
            ["description": "This evening, listen to an entire albumn all the way through.",
             "tags": ["Creative pursuits"]]
        ]

        var body: some View {
                NavigationView {
                    VStack {
                        Spacer() // Push content up

                        Text(selectedActivity ?? "No activity selected")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        
                        
                        Text(formattedDate())
                            .font(.headline)
                            .foregroundColor(.gray) // Gray color for the date
                            .padding(.bottom, 10)
                        
                        Button(action: {
                            refreshActivity()
                        }) {
                            Image(systemName: "arrow.clockwise.circle")
                                .foregroundColor(.gray)
                                .font(.system(size: 20))
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .onAppear {
                        requestNotificationPermissions()
                        scheduleDailyNotification()
                    }
                    .navigationBarItems(trailing:
                        NavigationLink(destination: SettingsView()) {
                        Image("gearIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40) // Adjust size as needed
                            .padding()
                        
                        }
                    )
                    .navigationBarItems(leading:
                        NavigationLink(destination: CalendarView()) {
                        Image("calendarIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40) // Adjust size as needed
                            .padding()
                        
                        }
                    )
                }
            }
        
        private func formattedDate() -> String {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "M/dd/yy"
               return dateFormatter.string(from: Date())
           }
        
        private func requestNotificationPermissions() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Notification permissions granted")
                } else {
                    print("Notification permissions denied")
                }
            }
        }
        
        private func randomActivity() -> String? {
            let filteredActivities = dailyActivities.filter { activity in
                guard let tags = activity["tags"] as? [String] else { return false }
                for tag in tags {
                    switch tag {
                    case "Creative pursuits":
                        if !settings.creativePursuitsEnabled { return false }
                    case "Outdoor activities":
                        if !settings.outdoorActivitiesEnabled { return false }
                    case "Health and wellness":
                        if !settings.healthAndWellnessEnabled { return false }
                    case "Social activities":
                        if !settings.socialActivitiesEnabled { return false }
                    case "Self improvement":
                        if !settings.selfImprovementEnabled { return false }
                    default:
                        break
                    }
                }
                return true
            }
            
            return filteredActivities.randomElement()?["description"] as? String
        }
        
        private func refreshActivity() {
               selectedActivity = randomActivity()
       }
        
        
        //THIS SHIT MAY NOT WORK 
        private func scheduleDailyNotification() {
            // Check if activity should be updated for the day
            let lastUpdatedDate = UserDefaults.standard.object(forKey: "lastUpdatedDate") as? Date
            let currentDate = Date()
            
            if lastUpdatedDate == nil || !Calendar.current.isDate(lastUpdatedDate!, inSameDayAs: currentDate) {
                // Select a random activity for the day
                selectedActivity = randomActivity()
                
                // Update last updated date
                UserDefaults.standard.set(currentDate, forKey: "lastUpdatedDate")
            }
            
            // If selected activity is nil, set it to a random value
            if selectedActivity == nil {
                selectedActivity = randomActivity()
            }
            
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Switch it up"
            notificationContent.body = selectedActivity ?? ""
                        
            var datComp = DateComponents()
            datComp.hour = 6
            datComp.minute = 00
            let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
            let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error : Error?) in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
            }
        }
    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
