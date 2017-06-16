//
//  CoreDataHelp.swift
//  Pokemon
//
//  Created by Salih Alborno on 15/06/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemons() {
    
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Meowth", imageName: "mewoth")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Pidgey", imageName: "pidgey")
    createPokemon(name: "Pikachu", imageName: "pikachu")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Weedle", imageName: "weedle")
    createPokemon(name: "Zubat", imageName: "zubat")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func createPokemon(name: String, imageName: String) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    
    pokemon.name = name
    pokemon.imageName = imageName
}

func getAllPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        if pokemons.count == 0 {
            addAllPokemons()
            return getAllPokemons()
        }
        return pokemons
    } catch {
        return []
    }
    
}


func getAllCaughtPokemons() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {
        return []
    }
}

func getAllUncaughtPokemons() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {
        return []
    }
}
