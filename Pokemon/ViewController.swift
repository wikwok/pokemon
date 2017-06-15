//
//  ViewController.swift
//  Pokemon
//
//  Created by Salih Alborno on 15/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print ("Ready to Go Pokemon")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()   //.requestAlwaysAuthorization() even when app is closed, can cause mistrust with users, dains battery. Check privacy settings to match.
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("We made it: \(updateCount)")
        if updateCount < 20 {
            let region = MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 400, 400)
            mapView.setRegion(region, animated: false) //animated: true, causes map fuzzy start, if you want!
            updateCount += 1
        } else {
            manager.stopUpdatingLocation() //to save battery life
        }
    }
    
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate { //to stop app crashing when updating location
            let region = MKCoordinateRegionMakeWithDistance(coord, 400, 400)
            mapView.setRegion(region, animated: true)
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

