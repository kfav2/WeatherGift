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
}
