//
//  ViewController.swift
//  TestLocation
//
//  Created by Olya Tilichenko on 27.02.2018.
//  Copyright © 2018 Olya Tilichenko. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {
    
    var placesClient: GMSPlacesClient!
    private let locationManager = CLLocationManager()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                }
            }
        })
    }
}
