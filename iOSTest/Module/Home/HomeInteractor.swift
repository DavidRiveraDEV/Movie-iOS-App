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
    
    func getPopularMoviesFiltered(value: String) {
        self.localDatamanager?.getPopularMoviesFiltered(value: value)
    }
    
    func getTopRatedMoviesFiltered(value: String) {
        self.localDatamanager?.getTopRatedMoviesFiltered(value: value)
    }
    
    func getUpcomingMoviesFiltered(value: String) {
        self.localDatamanager?.getUpcomingMoviesFiltered(value: value)
    }
    
    private func setCategory(_ category: Category, to movies: [Movie]) -> [Movie]{
        return movies.map({ movie in
            let movieToSave = Movie()
            movieToSave.id = movie.id
            movieToSave.title = movie.title
            movieToSave.overview = movie.overview
            movieToSave.releaseDate = movie.releaseDate
            movieToSave.rating = movie.rating
            movieToSave.posterPath = movie.posterPath
            movieToSave.backdropPath = movie.backdropPath
            movieToSave.category = category.rawValue
            return movieToSave
        })
    }
}

extension HomeInteractor: HomeLocalDataManagerOutputProtocol, HomeRemoteDataManagerOutputProtocol {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse) {
        var finalMovies: [Movie] = []
        if let movies = moviesResponse.movies {
            finalMovies = movies
        }
        if self.loadingPopularMoviesRemotely {
            finalMovies = self.setCategory(.popular, to: finalMovies)
            self.localDatamanager?.clearPopularMovies()
            _ = self.localDatamanager?.saveMovies(finalMovies)
            self.loadingPopularMoviesRemotely = false
        }
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
        if self.loadingTopRatedMoviesRemotely {
            finalMovies = self.setCategory(.topRated, to: finalMovies)
            self.localDatamanager?.clearTopRatedMovies()
            _ = self.localDatamanager?.saveMovies(finalMovies)
            self.loadingTopRatedMoviesRemotely = false
        }
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
        if self.loadingUpcomingMoviesRemotely {
            finalMovies = self.setCategory(.upcoming, to: finalMovies)
            self.localDatamanager?.clearUpcomingMovies()
            _ = self.localDatamanager?.saveMovies(finalMovies)
            self.loadingUpcomingMoviesRemotely = false
        }
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
