//
//  LocationDetailViewController.swift
//  WeatherGift
//
//  Created by Korlin Favara on 1/6/22.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherLocation: WeatherLocation!
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if weatherLocation == nil {
            weatherLocation = WeatherLocation(name: "Current Location", latitude: 0, longitude: 0)
            weatherLocations.append(weatherLocation)
        }
        loadLocations()
        updateUserInterface()
    }
    
    func loadLocations() {
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data else {
            print("Warning: Could not load weather locations data from user defaults. This would always be the casse the first time you install the app, so if that is the case, ignore this error")
            return
        }
        let decoder = JSONDecoder()
        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
            self.weatherLocations = weatherLocations
        } else {
            print("ERROR: could not decode data from userDefaults. ")
        }
    }
    
    func updateUserInterface() {
        dateLabel.text = "\(Date())"
        placeLabel.text = weatherLocation.name
        temperatureLabel.text = "--°"
        summaryLabel.text = ""
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! LocationListViewController
            //let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.weatherLocations = weatherLocations
    }
    
    @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! LocationListViewController
        weatherLocations = source.weatherLocations
        weatherLocation = weatherLocations[source.selectedLocationIndex]
        updateUserInterface()
    }
    
}
