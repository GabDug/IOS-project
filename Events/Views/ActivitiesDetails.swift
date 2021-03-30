
import SwiftUI

struct ActivitiesDetails: View {
    var activity: Activity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(activity.fields.name)
                    .font(.title)

                HStack {
                    Text(activity.fields.description ?? "")
                    Spacer()
                    Text(activity.fields.type)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(activity.fields.name)")
                    .font(.title2)
                Text(activity.fields.description ?? "")
            }
            .padding()
        }
        .navigationTitle(activity.fields.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActivitiesDetails_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesDetails(activity: activities[0])
    }
}
