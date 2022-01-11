//
//  LocationListViewController.swift
//  WeatherGift
//
//  Created by Korlin Favara on 1/5/22.
//

import UIKit
import GooglePlaces

class LocationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var weatherLocations: [WeatherLocation] = []
    var selectedLocationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func saveLocations() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weatherLocations) {
            UserDefaults.standard.set(encoded, forKey: "weatherLocations")
        } else {
            print("ERROR: Saving encoded didn't work!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedLocationIndex = tableView.indexPathForSelectedRow!.row
        saveLocations() 
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
    }
    @IBAction func addLocationPressed(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
         autocompleteController.delegate = self

         // Display the autocomplete view controller.
         present(autocompleteController, animated: true, completion: nil)
    }
}



extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weatherLocations[indexPath.row].name
        cell.detailTextLabel?.text = "Longitude: \(weatherLocations[indexPath.row].longitude), Latitude: \(weatherLocations[indexPath.row].latitude)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           weatherLocations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let weatherLocationToMove = weatherLocations[sourceIndexPath.row]
        weatherLocations.remove(at: sourceIndexPath.row)
        weatherLocations.insert(weatherLocationToMove, at: destinationIndexPath.row)
    }
}

extension LocationListViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
      let newLocation = WeatherLocation(name: place.name ?? "unknown place", latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
      weatherLocations.append(newLocation)
      tableView.reloadData()
    
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
