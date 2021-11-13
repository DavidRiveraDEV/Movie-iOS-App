//
//  HomeRemoteDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation
import SwiftUI

class HomeRemoteDataManager {
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    var movieService: MovieService
    
    init() {
        self.movieService = MovieService()
    }
}

extension HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    func getPopularMovies() {
        self.movieService.getPopularMovies { [weak self] movies in
            self?.remoteRequestHandler?.onPopularMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.remoteRequestHandler?.onPopularMoviesError(response)
        }

    }
    
    func getTopRatedMovies() {
        self.movieService.getTopRatedMovies { [weak self] movies in
            self?.remoteRequestHandler?.onTopRatedMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.remoteRequestHandler?.onTopRatedMoviesError(response)
        }
    }
    
    func getUpcomingMovies() {
        self.movieService.getUpcomingMovies { [weak self] movies in
            self?.remoteRequestHandler?.onUpcomingMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.remoteRequestHandler?.onUpcomingMoviesError(response)
        }
    }
}
