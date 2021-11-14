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
    var localDatamanager: HomeDataManagerInputProtocol?
    var remoteDatamanager: HomeDataManagerInputProtocol?
}

extension HomeInteractor: HomeDataManagerOutputProtocol {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse) {
        let movies: [Movie]? = moviesResponse.movies?.map({ movie in
            movie.category = Category.popular.rawValue
            return movie
        })
        print(movies)
    }
    
    func onPopularMoviesError(_ response: FailedResponse) {
    }
    
    func onTopRatedMoviesSuccess(_ moviesResponse: MoviesResponse) {
        let movies: [Movie]? = moviesResponse.movies?.map({ movie in
            movie.category = Category.topRated.rawValue
            return movie
        })
        print(movies)

    }
    
    func onTopRatedMoviesError(_ response: FailedResponse) {
    }
    
    func onUpcomingMoviesSuccess(_ moviesResponse: MoviesResponse) {
        let movies: [Movie]? = moviesResponse.movies?.map({ movie in
            movie.category = Category.upcoming.rawValue
            return movie
        })
        print(movies)

    }
    
    func onUpcomingMoviesError(_ response: FailedResponse) {
    }
    
}
