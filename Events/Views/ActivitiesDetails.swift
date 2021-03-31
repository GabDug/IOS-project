
import SwiftUI
import MapKit

// Extends it to make it work with MapKit pin (Requires Identifiable)
extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct ActivitiesDetails: View {
    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity;
    }
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State private var annotations: Array<CLLocationCoordinate2D> = []

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
                
                Divider()
                
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    MapPin(coordinate: $0)
                }
                    .frame(width: 400, height: 300)
            }
            .padding()
        }
        .navigationTitle(activity.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            LocationUtils.coordinates(forAddress: "TODO: Replace me pls", completion: {
                (location) in
                guard let location = location else {
                    // Handle error here.
                    print("Error smth")
                    return
                }
                
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                annotations.removeAll()
                annotations.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            })
        })
    }
}

struct ActivitiesDetails_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesDetails(activity: activities[0])
    }
}
