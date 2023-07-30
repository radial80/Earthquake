//
//  EarthquakeManager.swift
//  Earthquake
//
//  Created by Recep Uyduran on 6.03.2023.
//

import Foundation
protocol EarthquakeManagerDelegate: AnyObject {
    func didUpdateEarthquake(response: BaseData)
    func didFailWithError(error: Error)
}

class EarthquakeManager {
    let baseURL = "http://hasanadiguzel.com.tr/api/sondepremler"
    weak var delegate: EarthquakeManagerDelegate?

    func getEartquakes(){
        let urlString = "\(baseURL)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data,
                      let earthquake = self.parseJson(data),
                      error == nil else {
                    return
                }
                self.delegate?.didUpdateEarthquake(response: earthquake)
            }
            task.resume()
        }
    }
    func parseJson(_ data: Data) -> BaseData? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(BaseData.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
