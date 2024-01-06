//
//  DataPersistenceManager.swift
//  MovieApp
//
//  Created by Sevar Jafarli on 05.01.24.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToDeleteData
    }
    public func saveMovie(model: MovieViewModel, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let isMovieInList = isMovieInList(viewModel: model)
        if(!isMovieInList) {
            let savedMovie = SavedMovie(context: context)
            savedMovie.id = Int32(model.id  )
            savedMovie.movieTitle = model.movieTitle
            savedMovie.posterPath = model.posterPath
            savedMovie.overview = model.overview
            savedMovie.voteAverage = model.voteAverage ?? 0
            savedMovie.releaseDate = model.releaseDate
            
            do {
                try context.save()
                completion(.success(true))
            }
            catch {
                print(error.localizedDescription)
                completion(.failure(DatabaseError.failedToSaveData))
            }
            
        }
        else {
            completion(.success(false))
        }
        
    }
    
    public func isMovieInList(viewModel: MovieViewModel) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
        
        // Set a predicate to check for specific conditions (if needed)
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(viewModel.id)")
        
        // Perform the fetch request
        do {
            let results = try context.fetch(fetchRequest)
            
            let isMovieInList = !results.isEmpty
            return isMovieInList
        } catch {
            print("Error fetching data: \(error)")
            return false
        }
    }
    
    public func deleteMovie(model: MovieViewModel, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        // Create a fetch request for the entity
        let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
        
        // Set a predicate to identify the object you want to delete (for example, based on an ID)
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(model.id)")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let objectToDelete = results.first {
                context.delete(objectToDelete)
                
                // Save changes to persist the deletion
                try context.save()
                completion(.success(true))
                
            } else {
                completion(.success(false))
            }
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
    public func getSavedMovies() -> [SavedMovie] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results
            
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
        
    }
}
