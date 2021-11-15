//
//  DetailRouter.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation
import UIKit

class DetailRouter: DetailRouterProtocol {

    class func createModule(withMovieId id: Int, andCategory category: Category) -> UIViewController {
        if let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailView") as? DetailView {
            let presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
            let interactor: DetailInteractorInputProtocol & DetailLocalDataManagerOutputProtocol & DetailRemoteDataManagerOutputProtocol = DetailInteractor()
            let localDataManager: DetailLocalDataManagerInputProtocol = DetailLocalDataManager()
            let remoteDataManager: DetailRemoteDataManagerInputProtocol = DetailRemoteDataManager()
            let router: DetailRouterProtocol = DetailRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.movieId = id
            presenter.category = category
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            localDataManager.dataManagerRequestHandler = interactor
            remoteDataManager.dataManagerRequestHandler = interactor
            
            return view
        }
        return UIViewController()
    }
}
