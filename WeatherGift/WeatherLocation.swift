//
//  WeatherLocations.swift
//  WeatherGift
//
//  Created by Korlin Favara on 1/5/22.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // Getting data via URLSession
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"

        print("We are accessing the url \(urlString)")
        
        // Create url
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create url from \(urlString)")
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // Get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            // note: there are some additional things that could go wrong when using URLSession, but we shouldn't be experiencing them, so we will ignore testing them for now..
            
            // deal with the data
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
