//
//  CoreDataManager.swift
//  MovieDB
//
//  Created by Amali Krigger on 10/10/23.
//

import Foundation
import CoreData

class CoreDataManager: MovieDBRepository {
    
    let container = NSPersistentContainer(name: "MovieCoreDataModel")
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            print("Core Data Description: \(description)")
        }
    }
    lazy var managedContext: NSManagedObjectContext = self.container.viewContext
  
    func saveMovie(movie: Movie)async throws {
        let coreDataMovie = CoreDataMovie(context: managedContext)
    
        coreDataMovie.title = movie.title
//        coreDataMovie.genreIds = movie.genreIds
        coreDataMovie.id = Int64(movie.id)
        coreDataMovie.adult = movie.adult
        coreDataMovie.backdropPath = movie.backdropPath
        coreDataMovie.originalTitle = movie.originalTitle
        coreDataMovie.originalLanguage = movie.originalLanguage
        coreDataMovie.overview = movie.overview
        
        coreDataMovie.popularity = movie.popularity
        coreDataMovie.posterPath = movie.posterPath
        coreDataMovie.releaseDate = movie.releaseDate
        coreDataMovie.video = movie.video
        coreDataMovie.voteAverage = movie.voteAverage
        coreDataMovie.voteCount = Int64(movie.voteCount)
        do {
               try managedContext.save()
                print("MOVIE ITEM SAVED")
           }
           catch {
               fatalError("Unable to load sample data: \(error.localizedDescription)")
           }
    }
    func getMovies()async throws -> [Movie]{
        var result = [Movie]()
        let fetchRequest: NSFetchRequest<CoreDataMovie>
        fetchRequest = CoreDataMovie.fetchRequest()
        
            do {
                let objects = try self.managedContext.fetch(fetchRequest)
                if !objects.isEmpty{
                    objects.forEach{ object in
                        result.append(Movie(movieCoreData: object))
                    }
                }
            }
            catch{
                
            }
        
        return result
    }
    func deleteMovie(id:Int)async throws {
        let fetchRequest: NSFetchRequest<CoreDataMovie> = CoreDataMovie.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        do {
            let matchingEntries = try managedContext.fetch(fetchRequest)
            
            for entry in matchingEntries {
                managedContext.delete(entry)
            }
            
            try managedContext.save()
            print("Core data entry with id \(id) DELETED!")
        } catch {
            print("Error deleting entry: \(error.localizedDescription)")
        }
    }
}
