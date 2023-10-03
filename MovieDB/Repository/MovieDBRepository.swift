//
//  MovieDBRepository.swift
//  MovieDB
//
//  Created by Uche Godfrey on 10/2/23.
//

import Foundation
protocol MovieDBRepository{
    func getMovie() -> Movie?
    func getMovies() -> [Movie]?
    func saveMovie(movie:Movie)
    func deleteMovie(id:Int)
    
}
extension MovieDBRepository{
    func getMovie() -> Movie?{
        var movie:Movie? = nil
        return movie
        
    }
    func getMovies() -> [Movie]?{
        var movies:[Movie]? = nil
        return movies
    }
    func saveMovie(movie:Movie){
        print("Define this method")
    }
    func deleteMovie(id:Int){
        print("Define delete movie method")
    }
}
