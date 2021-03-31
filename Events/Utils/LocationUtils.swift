import MapKit

class LocationUtils {
    static func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
                guard error == nil else {
                    print("Geocoding error: \(error!)")
                    completion(nil)
                    return
                }
                
                completion(placemarks?.first?.location?.coordinate)
        }
    }
}
