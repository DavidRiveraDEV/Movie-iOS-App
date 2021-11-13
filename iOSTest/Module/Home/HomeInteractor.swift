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
}

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse) {
    }
    
    func onPopularMoviesError(_ response: FailedResponse) {
    }
    
    func onTopRatedMoviesSuccess(_ moviesResponse: MoviesResponse) {
    }
    
    func onTopRatedMoviesError(_ response: FailedResponse) {
    }
    
    func onUpcomingMoviesSuccess(_ moviesResponse: MoviesResponse) {
    }
    
    func onUpcomingMoviesError(_ response: FailedResponse) {
    }
    
}
