//
//  HomePresenter.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation

class HomePresenter {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
}
