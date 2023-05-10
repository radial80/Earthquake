//
//  WeatherManagerModel.swift
//  Earthquake
//
//  Created by Kasım Sağır on 6.03.2023.
//

import Foundation

struct EarthquakeManagerModel {
    let gün : Date
    var günString: String {
        return String(format: "Date", gün as CVarArg)
    }
    let saat: Date
    var saatString: String {
        return String(format: "Date", saat as CVarArg)
    }
    let mag: Double
    let loca: String
    var magString: String {
        return String(format: "%1.f", mag)
    }
}

