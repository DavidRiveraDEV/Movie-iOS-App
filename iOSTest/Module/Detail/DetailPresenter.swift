//
//  DetailPresenter.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation

class DetailPresenter  {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var router: DetailRouterProtocol?
    
    var movieId: Int?
    var category: Category?
    
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func viewDidLoad() {
        self.interactor?.getMovie(id: movieId!, withCategory: category!)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func updateMovie(_ movie: Movie) {
        self.view?.updateMovie(movie)
    }
    
}
