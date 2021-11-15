//
//  DetailProtocols.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    
    var presenter: DetailPresenterProtocol? { get set }
    
    func updateMovie(_ movie: Movie)
}

protocol DetailRouterProtocol: AnyObject {
    
    static func createModule(withMovieId id: Int, andCategory category: Category) -> UIViewController
}

protocol DetailPresenterProtocol: AnyObject {
    
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    var movieId: Int? { get set }
    var category: Category? { get set }
    
    func viewDidLoad()
}

protocol DetailInteractorOutputProtocol: AnyObject {
    
    func updateMovie(_ movie: Movie)
}

protocol DetailInteractorInputProtocol: AnyObject {
    
    var presenter: DetailInteractorOutputProtocol? { get set }
    var localDatamanager: DetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DetailRemoteDataManagerInputProtocol? { get set }
    
    func getMovie(id: Int, withCategory category: Category)
}

protocol DetailDataManagerInputProtocol: AnyObject {
    
    func getMovie(id: Int)
}

protocol DetailDataManagerOutputProtocol: AnyObject {
    
    func onMovieSuccess(_ movieResponse: Movie)
    func onMovieError(_ response: FailedResponse)
}

protocol DetailRemoteDataManagerInputProtocol: DetailDataManagerInputProtocol {
    
    var dataManagerRequestHandler: DetailRemoteDataManagerOutputProtocol? { get set }
}

protocol DetailRemoteDataManagerOutputProtocol: DetailDataManagerOutputProtocol {
    
}

protocol DetailLocalDataManagerInputProtocol: DetailDataManagerInputProtocol {
    
    var dataManagerRequestHandler: DetailLocalDataManagerOutputProtocol? { get set }
}

protocol DetailLocalDataManagerOutputProtocol: DetailDataManagerOutputProtocol {
    
}
