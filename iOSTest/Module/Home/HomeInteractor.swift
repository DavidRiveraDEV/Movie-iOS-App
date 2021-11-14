//
//  HomeInteractor.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    private var loadingPopularMoviesRemotely: Bool = false
    private var loadingTopRatedMoviesRemotely: Bool = false
    private var loadingUpcomingMoviesRemotely: Bool = false
    
    func getPopularMovies() {
        self.loadingPopularMoviesRemotely = true
        self.remoteDatamanager?.getPopularMovies()
    }
    
    func getTopRatedMovies() {
        self.loadingTopRatedMoviesRemotely = true
        self.remoteDatamanager?.getTopRatedMovies()
    }
    
    func getUpcomingMovies() {
        self.loadingUpcomingMoviesRemotely = true
        self.remoteDatamanager?.getUpcomingMovies()
    }
    
    private func saveMovies(_ movies: [Movie], withCategory category: Category) {
        switch category {
        case .popular:
            self.localDatamanager?.clearPopularMovies()
        case .topRated:
            self.localDatamanager?.clearTopRatedMovies()
        case .upcoming:
            self.localDatamanager?.clearUpcomingMovies()
        }
        let moviesToSave: [Movie] = movies.map({ movie in
            movie.category = category.rawValue
            return movie
        })
        _ = self.localDatamanager?.saveMovies(moviesToSave)
    }
}

extension HomeInteractor: HomeLocalDataManagerOutputProtocol, HomeRemoteDataManagerOutputProtocol {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse) {
        var finalMovies: [Movie] = []
        if let movies = moviesResponse.movies {
            finalMovies = movies
        }
        self.saveMovies(finalMovies, withCategory: .popular)
        self.loadingPopularMoviesRemotely = false
        self.presenter?.updatePopularMovies(finalMovies)
    }
    
    func onPopularMoviesError(_ response: FailedResponse) {
        if self.loadingPopularMoviesRemotely {
            self.loadingPopularMoviesRemotely = false
            self.localDatamanager?.getPopularMovies()
        } else {
            self.presenter?.updatePopularMovies([])
        }
    }
    
    func onTopRatedMoviesSuccess(_ moviesResponse: MoviesResponse) {
        var finalMovies: [Movie] = []
        if let movies = moviesResponse.movies {
            finalMovies = movies
        }
        self.saveMovies(finalMovies, withCategory: .topRated)
        self.loadingTopRatedMoviesRemotely = false
        self.presenter?.updateTopRatedMovies(finalMovies)
    }
    
    func onTopRatedMoviesError(_ response: FailedResponse) {
        if self.loadingTopRatedMoviesRemotely {
            self.loadingTopRatedMoviesRemotely = false
            self.localDatamanager?.getTopRatedMovies()
        } else {
            self.presenter?.updateTopRatedMovies([])
        }
    }
    
    func onUpcomingMoviesSuccess(_ moviesResponse: MoviesResponse) {
        var finalMovies: [Movie] = []
        if let movies = moviesResponse.movies {
            finalMovies = movies
        }
        self.saveMovies(finalMovies, withCategory: .upcoming)
        self.loadingUpcomingMoviesRemotely = false
        self.presenter?.updateUpcomingMovies(finalMovies)
    }
    
    func onUpcomingMoviesError(_ response: FailedResponse) {
        if self.loadingUpcomingMoviesRemotely {
            self.loadingUpcomingMoviesRemotely = false
            self.localDatamanager?.getUpcomingMovies()
        } else {
            self.presenter?.updateUpcomingMovies([])
        }
    }
}
