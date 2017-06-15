//
//  CoreDataHelp.swift
//  Pokemon
//
//  Created by Salih Alborno on 15/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import CoreData

func createPokemon() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    
    pokemon.name = "Mew"
    pokemon.imageName = "mew"
}
