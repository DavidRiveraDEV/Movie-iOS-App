//
//  HomeRemoteDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation

class HomeRemoteDataManager {
    
    var dataManagerRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    let remoteMovieService: RemoteMovieService
    
    init() {
        self.remoteMovieService = RemoteMovieService()
    }
}

extension HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    func getPopularMovies() {
        self.remoteMovieService.getPopularMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onPopularMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onPopularMoviesError(response)
        }
    }
    
    func getTopRatedMovies() {
        self.remoteMovieService.getTopRatedMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onTopRatedMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onTopRatedMoviesError(response)
        }
    }
    
    func getUpcomingMovies() {
        self.remoteMovieService.getUpcomingMovies { [weak self] movies in
            self?.dataManagerRequestHandler?.onUpcomingMoviesSuccess(movies)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onUpcomingMoviesError(response)
        }
    }
}
