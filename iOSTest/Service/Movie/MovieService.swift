//
//  MovieService.swift
//  iOSTest
//
//  Created by David Rivera on 13/11/21.
//

import Foundation

protocol MovieService {
    
    func getMovie(id: Int, onSuccess: @escaping (_ movie: Movie) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    func getPopularMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    func getTopRatedMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
    func getUpcomingMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void)
}

protocol LocalMovieServiceProtocol {
    
    func saveMovies(_ movies: [Movie]) -> Bool
    
    func clearPopularMovies()
    func clearTopRatedMovies()
    func clearUpcomingMovies()
    
}
