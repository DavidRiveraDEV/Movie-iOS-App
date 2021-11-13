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
}

protocol HomeRouterProtocol: AnyObject {

}

protocol HomePresenterProtocol: AnyObject {

    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    
}

protocol HomeInteractorInputProtocol: AnyObject {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
}

protocol HomeDataManagerInputProtocol: AnyObject {
    
    func getPopularMovies()
    func getTopRatedMovies()
    func getUpcomingMovies()
}

protocol HomeRemoteDataManagerInputProtocol: HomeDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    
    func onPopularMoviesSuccess(_ moviesResponse: MoviesResponse)
    func onPopularMoviesError(_ response: FailedResponse)
    func onTopRatedMoviesSuccess(_ moviesResponse: MoviesResponse)
    func onTopRatedMoviesError(_ response: FailedResponse)
    func onUpcomingMoviesSuccess(_ moviesResponse: MoviesResponse)
    func onUpcomingMoviesError(_ response: FailedResponse)
}

protocol HomeLocalDataManagerInputProtocol: HomeDataManagerInputProtocol {

}
