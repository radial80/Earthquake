//
//  CoinManagerData.swift
//  Earthquake
//
//  Created by Recep Uyduran on 6.03.2023.
//

import Foundation

struct BaseData: Codable {
    let data: [EarthquakeManagerData]
}

struct EarthquakeManagerData: Codable {
    let tarih: String
    let saat: String
    let ml: Double 
    let yer: String
    var mlString: String {
        return String(format: "%.1f", ml)
    }
}
