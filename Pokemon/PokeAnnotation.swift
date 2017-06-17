//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Salih Alborno on 17/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation { //subclass
    var coordinate: CLLocationCoordinate2D //required by default
    var pokemon: Pokemon
    init(coord: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
}
