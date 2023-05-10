
import Foundation

struct EarthquakeManagerModel {
    let tarih : String


    let saat: String
    let ml: Double
    let yer: String
    var magString: String {
        return String(format: "%1.f", ml)
    }
}
