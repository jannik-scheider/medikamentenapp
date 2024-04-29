//
//  DataController.swift
//  icalorie
//
//  Created by Jannik Scheider on 27.04.24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "MedikamentModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addMedikament(name: String, date: Date, context: NSManagedObjectContext) {
        let medikament = Medikament(context: context)
        medikament.id = UUID()
        medikament.date = date
        medikament.name = name
        
        save(context: context)
    }
    
    func editMedikament(medikament: Medikament, name: String, date: Date, context: NSManagedObjectContext) {
        medikament.date = date
        medikament.name = name
        
        save(context: context)
    }
}
