
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
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 400, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
                    
            }
            .padding()
        }
        .navigationTitle(activity.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            LocationUtils.coordinates(forAddress: "59 Rue Marcel Grosmenil 94800 Villejuif", completion: {
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
