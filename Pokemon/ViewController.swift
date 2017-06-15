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
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //spwan a pokemon
                print("Timer \(timer)")
                if let coord = self.manager.location?.coordinate {
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    
                    let randoLat = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    let randoLon = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    
                    anno.coordinate.latitude += randoLat
                    anno.coordinate.longitude += randoLon
                    
                    self.mapView.addAnnotation(anno)
                }
            })
            
        } else {
            manager.requestWhenInUseAuthorization()   //.requestAlwaysAuthorization() even when app is closed, can cause mistrust with users, dains battery. Check privacy settings to match.
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("We made it: \(updateCount)")
        if updateCount < 20 {
            let region = MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 200, 200)
            mapView.setRegion(region, animated: false) //animated: true, causes map fuzzy start, if you want!
            updateCount += 1
        } else {
            manager.stopUpdatingLocation() //to save battery life
        }
    }
    
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate { //to stop app crashing when updating location
            let region = MKCoordinateRegionMakeWithDistance(coord, 200, 200)
            mapView.setRegion(region, animated: true)
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

