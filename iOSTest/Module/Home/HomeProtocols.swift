//
//  HomeProtocols.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func updatePopularMovies(_ movies: [Movie])
    func updateTopRatedMovies(_ movies: [Movie])
    func updateUpcomingMovies(_ movies: [Movie])
}

protocol HomeRouterProtocol: AnyObject {

    func openMovieDetailView(from view: HomeViewProtocol, withMovieId id: Int)
}

protocol HomePresenterProtocol: AnyObject {

    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func movieDidSelected(id: Int)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    
    func updatePopularMovies(_ movies: [Movie])
    func updateTopRatedMovies(_ movies: [Movie])
    func updateUpcomingMovies(_ movies: [Movie])
}

protocol HomeInteractorInputProtocol: AnyObject {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    func getPopularMovies()
    func getTopRatedMovies()
    func getUpcomingMovies()
}

protocol HomeDataManagerInputProtocol: AnyObject {
    
    func getPopularMovies()
    func getTopRatedMovies()
    func getUpcomingMovies()
}

protocol HomeDataManagerOutputProtocol: AnyObject {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse)
    func onPopularMoviesError(_ response: FailedResponse)
    func onTopRatedMoviesSuccess(_ moviesResponse: MoviesResponse)
    func onTopRatedMoviesError(_ response: FailedResponse)
    func onUpcomingMoviesSuccess(_ moviesResponse: MoviesResponse)
    func onUpcomingMoviesError(_ response: FailedResponse)
}

protocol HomeRemoteDataManagerInputProtocol: HomeDataManagerInputProtocol {
    
    var dataManagerRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
}

protocol HomeRemoteDataManagerOutputProtocol: HomeDataManagerOutputProtocol {
    
}

protocol HomeLocalDataManagerInputProtocol: HomeDataManagerInputProtocol {
    
    var dataManagerRequestHandler: HomeLocalDataManagerOutputProtocol? { get set }
    
    func saveMovies(_ movies: [Movie]) -> Bool
    func clearPopularMovies()
    func clearTopRatedMovies()
    func clearUpcomingMovies()
}

protocol HomeLocalDataManagerOutputProtocol: HomeDataManagerOutputProtocol {
    
}
