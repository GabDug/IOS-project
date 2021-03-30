/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct ActivitesList: View {
    var body: some View {
        NavigationView {
            List(activities) { activity in
                NavigationLink(destination: ActivitiesDetails(activity: activity)) {
                    ActivitiesRow(activity: activity)
                }
            }
            .navigationTitle("Activities")
        }
    }
}

struct ActivitesList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            ActivitesList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
