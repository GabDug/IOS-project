
import SwiftUI

struct ActivitiesDetails: View {
    var activity: Activity
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(activity.fields.name)
                    .font(.title)
                
                HStack {
                    Text(activity.fields.type)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About this activity")
                    .font(.title2)
                Text(activity.fields.description ?? "No description for this event.").font(.body).fixedSize(horizontal: false, vertical: true)
                
                Divider()
                
                Text("Starting \(activity.fields.startDate, formatter: Self.taskDateFormat)")
                Text("Ending \(activity.fields.endDate, formatter: Self.taskDateFormat)")
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
