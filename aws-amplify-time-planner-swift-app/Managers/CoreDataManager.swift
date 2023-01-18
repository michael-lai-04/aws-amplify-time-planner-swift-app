//
//  CoreDataManager.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 17/1/2023.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistantContainer: NSPersistentContainer
    
    init(){
        persistantContainer = NSPersistentContainer(name: "aws-amplify-time-planner-swift-app-model")
        persistantContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func getAllMovies() -> [Movie]{
        
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            return try persistantContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func saveMovie(title:String){
        
        let movie = Movie(context:persistantContainer.viewContext)
        movie.title = title
        
        do{
            try persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
    
    func updateMovie(){
        do{
            try persistantContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
    
    func deleteMovie(movie: Movie) {
        persistantContainer.viewContext.delete(movie)
        
        do{
            try persistantContainer.viewContext.save()
        }catch{
            persistantContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
}
