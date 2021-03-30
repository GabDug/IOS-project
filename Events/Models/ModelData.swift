import Foundation

private var root: Root = load("activities.json")
private var  rootSponsors: RootSponsors = load("sponsor.json")
var activities: [Activity] = root.activities
var sponsors: [Sponsor] = rootSponsors.sponsors

var sponsorCategories: [String: [Sponsor]] {
    Dictionary(
        grouping: sponsors,
        by: { $0.fields.status }
    )
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        // Dates are in this format: 2019-11-15T14:30:00.000Z
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let rootJson = try decoder.decode(T.self, from: data)
        // let workers = rootJson.activities  // all workers objects
        return rootJson
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
