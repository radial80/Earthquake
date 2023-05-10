//
//  WeatherManagerModel.swift
//  Earthquake
//
//  Created by Kasım Sağır on 6.03.2023.
//{"tarih":"2023.03.07",
//    "saat":"12:55:54",
//    "enlem_n":37.709,
//    "boylam_e":36.5747,"derinlik_km":27.2,
//    "md":"-.-",
//"ml":2.2,
//    "mw":"-.-",
//"yer":"CINARPINAR-(KAHRAMANMARAS)",
//    "cozum_niteligi":"Ãlksel"},

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
