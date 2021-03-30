/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct ActivitiesRow: View {
    var activity: Activity

    var body: some View {
        HStack {
//            activity.image
//                .resizable()
//                .frame(width: 50, height: 50)
            Text(activity.fields.name)

            Spacer()
        }
    }
}

struct ActivitesRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivitiesRow(activity: activities[0])
            ActivitiesRow(activity: activities[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
