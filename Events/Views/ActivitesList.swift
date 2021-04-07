/*
 
 */

import SwiftUI
import Foundation

extension Color {
    static let lightPink = Color(red: 236 / 255, green: 188 / 255, blue: 180 / 255)
    static let lightGray = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let lightOrange = Color(red: 219 / 255, green: 98 / 255, blue: 68 / 255)
    static let iconGray = Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255)
    static let lighterPink = Color(red: 233 / 255, green: 219 / 255, blue: 210 / 255)
    static let lighterGray = Color(red: 214 / 255, green: 214 / 255, blue: 214 / 255)
    static let pinkColor = Color(red: 227 / 255, green: 133 / 255, blue: 180 / 255)
    static let purpleColor = Color(red: 123 / 255, green: 119 / 255, blue: 233 / 255)
    static let OrangeColor = Color(red: 240 / 255, green: 146 / 255, blue: 171 / 255)
}
struct ActivitesList: View {
    @State private var isLoaded = false
    
    @State var small = true
    @Namespace var namespace
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    @State private var activities: Array<Activity> = []
    
    @State private var availableDates: [Date] = []
    @State private var selectedDate: Date = Date()
    
    
    
    init(activities: Array<Activity>?) {
        if (activities != nil) {
            self.activities = activities!
        }
    }
    
    var body: some View {
        NavigationView {
            HStack {
                ZStack {
                    BackgroundView()
                    // Actual Scrollview
                    ScrollView {
                        VStack {
                            HStack {
                                // Date picker per day
                                Text("Selected date:")
                                    .font(.title2)
                                
                                Picker(DateUtils.formattedStringFromDate(from: selectedDate), selection: $selectedDate) {
                                    ForEach(availableDates, id: \.self) {
                                        Text(DateUtils.formattedStringFromDate(from: $0))
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .font(.title2)
                            }
                            
                            // Display filtered activies
                            ForEach(
                                activities.filter { activity in
                                    DateUtils.dayOnlyDateFromDate(from: activity.fields.startDate) == selectedDate
                                }.sorted(by: { (a, b) -> Bool in
                                    return (b.fields.startDate.compare(a.fields.startDate) == .orderedDescending)
                                }),
                                id: \.self
                            ) { activity in
                                NavigationLink(destination: ActivitiesDetails(activity: activity)) {
                                    ActivitiesRow(activity: activity)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("Activities")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        // Notification Banner
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            // Prevent double loading
            if (isLoaded) {
                return
            }
            
            // Load activities
            ApiService.call(Root.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule") { (data) in
                isLoaded = true
                activities = data?.activities ?? []
                
                if (activities.count > 0) {
                    activities.forEach { activity in
                        let activityDate = DateUtils.dayOnlyDateFromDate(from: activity.fields.startDate)
                        
                        if (!availableDates.contains(activityDate)) {
                            availableDates.append(activityDate)
                        }
                    }
                    
                    availableDates = DateUtils.sortedDateArray(from: availableDates)
                    selectedDate = availableDates[0]
                }
            } errorHandler: { (error) in
                // Banner handling
                withAnimation { () -> Void in
                    switch (error) {
                    case .none:
                        break
                    case .some(.apiError(_, _)):
                        self.messageBanner = "An issue occured when querying the API"
                        break
                    case .some(.httpError(_)):
                        self.messageBanner = "We couldn't reach the API"
                        break
                    case .some(.parseError(_, _)):
                        self.messageBanner = "An issue occured while parsing the data"
                        break
                    }
                    
                    self.showOverlay = true
                }
            }
        })
    }
}

struct ActivitesList_Previews: PreviewProvider {
    static var previews: some View {
        // For preview we load fake local data
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            ActivitesList(activities: localActivities)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .preferredColorScheme(.dark)
    }
}
