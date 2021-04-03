import Foundation

class ApiService {
    private static var token = "keyOfs3xSW3WokaED"
    
    // Need to pass the type as an argument because type serialization
    static func call<T: Decodable>(_ returning: T.Type, url: String, completionHandler: @escaping (T?) -> Void) {
        let url = URL(string: url) // TODO: Remove the optional URL
        
        var request = URLRequest(url: url!)
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    // Dates are in this format: 2019-11-15T14:30:00.000Z
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
                    dateFormatter.locale = Locale(identifier: "en_US")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let decoded = try decoder.decode(T.self, from: data)
                    completionHandler(decoded)
                } catch {
                    print(error)
                }
            }
        })
        
        task.resume()
    }
}
