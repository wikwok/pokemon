//
//  ViewController.swift
//  Pokemon
//
//  Created by Salih Alborno on 15/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    var pokemons : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        pokemons = getAllPokemons()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print ("Ready to Go Pokemon")
            mapView.delegate = self
            
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //spwan a pokemon
                print("Timer \(timer)")
                if let coord = self.manager.location?.coordinate {
                    let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                    let anno = PokeAnnotation(coord: coord, pokemon: pokemon) // new sublcass with extra funtionality
                    //let anno = MKPointAnnotation() //has been extended using subclass as above line.
                    //anno.coordinate = coord //is replaced by subclass above and passed as argument
                    
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image = UIImage(named: "player")
            var frame = annoView.frame
            frame.size.height = 50
            frame.size.width = 50
            annoView.frame = frame
            
            return annoView

            //return nil //keeps blue dot
        }
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let pokemon = (annotation as! PokeAnnotation).pokemon
        annoView.image = UIImage(named: pokemon.imageName!)
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        annoView.frame = frame
        
        return annoView
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

