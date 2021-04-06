
import SwiftUI
import MapKit

// Extends it to make it work with MapKit pin (Requires Identifiable)
extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct ActivitiesDetails: View {
    @State private var isLoaded = false
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    var activity: Activity
    @State private var location: Location? = nil
    @State private var speakers: Array<Speaker> = []
    
    init(activity: Activity) {
        self.activity = activity;
    }
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    @State private var regionLoaded = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State private var annotations: Array<CLLocationCoordinate2D> = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text(activity.fields.name )
                        .font(.title)
                    
                    HStack {
                        Text(activity.fields.type )
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                
                Divider()
                
                Group {
                    Text("About this activity")
                        .font(.title2)
                    Text(activity.fields.description ?? "No description for this event.").font(.body).fixedSize(horizontal: false, vertical: true)
                }
                
                Divider()
                
                Group {
                    Text("Starting \(activity.fields.startDate , formatter: Self.taskDateFormat)")
                    Text("Ending \(activity.fields.endDate , formatter: Self.taskDateFormat)")
                }
                
                Divider()
                
                Group {
                    if (speakers.count > 0) {
                        SpeakerRow(speakers: speakers)
                    } else {
                        Text("No speakers registered for this activity.")
                    }
                }
                
                if (regionLoaded) {
                    Map(coordinateRegion: $region, annotationItems: annotations) {
                        MapPin(coordinate: $0)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 400, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            .padding()
        }
        .navigationTitle(activity.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            if (isLoaded) {
                return
            }
            
            if (activity.fields.speakersId != nil) {
                activity.fields.speakersId?.forEach({ (id) in
                    ApiService.call(Speaker.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees/\(id)") {
                        (data) in
                        isLoaded = true;
                        
                        if (data != nil) {
                            speakers.append(data!)
                        }
                    } errorHandler: { (error) in
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
            
            ApiService.call(Location.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Event%20locations/\(activity.fields.locationId?[0] ?? "")") { (data) in
                isLoaded = true
                location = data
                
                LocationUtils.coordinates(forAddress: location?.fields.buildingLocation ?? "", completion: {
                    (location) in
                    guard let location = location else {
                        withAnimation { () -> Void in
                            self.messageBanner = "Couldn't find the location of the event"
                            
                            self.showOverlay = true
                        }
                        
                        return
                    }
                    
                    DispatchQueue.main.async {
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        annotations.removeAll()
                        annotations.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                        regionLoaded = true
                    }
                })
            } errorHandler: { (error) in
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

struct ActivitiesDetails_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesDetails(activity: localActivities[1])
    }
}
