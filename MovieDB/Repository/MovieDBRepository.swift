//
//  MovieDBRepository.swift
//  MovieDB
//
//  Created by Uche Godfrey on 10/2/23.
//

import Foundation
protocol MovieDBRepository{
    func getMovie() -> Movie
    func saveMovie()
    func deleteMovie()
    
}
/*extension MovieDBRepositoryEx{
    
}*/
