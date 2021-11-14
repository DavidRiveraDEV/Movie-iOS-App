//
//  HomeRouter.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {

    class func createModule() -> UIViewController {
        if let view = mainStoryboard.instantiateViewController(withIdentifier: "HomeView") as? HomeView {
            let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
            let interactor: HomeInteractorInputProtocol & HomeLocalDataManagerOutputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
            let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
            let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
            let router: HomeRouterProtocol = HomeRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            localDataManager.dataManagerRequestHandler = interactor
            remoteDataManager.dataManagerRequestHandler = interactor
            
            return view
        }
        return UIViewController()
    }
    
    func openMovieDetailView(from view: HomeViewProtocol, withMovieId id: Int) {
//        if let movieDetailView = MovieDetailRouter.createModule(withMovieId: id)
//        if let view = view as? UIViewController {
//            view.navigationController?.pushViewController(movieDetailView, animated: true)
//        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
