//
//  HomeLocalDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation

class HomeLocalDataManager {
    
    var dataManagerRequestHandler: HomeLocalDataManagerOutputProtocol?
    
    let localMovieService: LocalMovieService
    
    init() {
        self.localMovieService = LocalMovieService()
    }
}

extension HomeLocalDataManager: HomeLocalDataManagerInputProtocol {    
    
    func saveMovies(_ movies: [Movie]) -> Bool {
        return self.localMovieService.saveMovies(movies)
    }
    
    func getPopularMovies() {
        self.localMovieService.getPopularMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onPopularMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onPopularMoviesError(response)
        }
    }
    
    func getTopRatedMovies() {
        self.localMovieService.getTopRatedMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onTopRatedMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onTopRatedMoviesError(response)
        }
    }
    
    func getUpcomingMovies() {
        self.localMovieService.getUpcomingMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onUpcomingMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onUpcomingMoviesError(response)
        }
    }
    
    func getPopularMoviesFiltered(value: String) {
        self.localMovieService.getPopularMoviesFiltered(value: value) { [weak self] movies in
            self?.dataManagerRequestHandler?.onPopularMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onPopularMoviesError(response)
        }

    }
    
    func getTopRatedMoviesFiltered(value: String) {
        self.localMovieService.getTopRatedMoviesFiltered(value: value) { [weak self] movies in
            self?.dataManagerRequestHandler?.onTopRatedMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onTopRatedMoviesError(response)
        }
    }
    
    func getUpcomingMoviesFiltered(value: String) {
        self.localMovieService.getUpcomingMoviesFiltered(value: value) { [weak self] movies in
            self?.dataManagerRequestHandler?.onUpcomingMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onUpcomingMoviesError(response)
        }
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

