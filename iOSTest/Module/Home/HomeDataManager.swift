//
//  HomeDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 13/11/21.
//

import Foundation

class HomeDataManager {
    
    var dataManagerRequestHandler: HomeDataManagerOutputProtocol?
    
    let movieService: MovieService
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
}

extension HomeDataManager: HomeDataManagerInputProtocol {
    
    func getPopularMovies() {
        self.movieService.getPopularMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onPopularMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onPopularMoviesError(response)
        }

    }
    
    func getTopRatedMovies() {
        self.movieService.getTopRatedMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onTopRatedMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onTopRatedMoviesError(response)
        }
    }
    
    func getUpcomingMovies() {
        self.movieService.getUpcomingMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onUpcomingMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onUpcomingMoviesError(response)
        }
    }
}
