//
//  HomeLocalDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation

class HomeLocalDataManager: HomeDataManager {
    
    let localMovieService: LocalMovieService
    
    init() {
        self.localMovieService = LocalMovieService()
        super.init(movieService: localMovieService)
    }
    
    func saveMovies(_ movies: [Movie]) -> Bool {
        return self.localMovieService.saveMovies(movies)
    }
    
    func clearPopularMovies() {
        self.localMovieService.clearPopularMovies()
    }
    
    func clearTopRatedMovies() {
        self.localMovieService.clearTopRatedMovies()
    }
    
    func clearUpcomingMovies() {
        self.localMovieService.clearUpcomingMovies()
    }
}
