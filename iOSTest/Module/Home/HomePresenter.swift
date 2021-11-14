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
        self.interactor?.getPopularMovies()
        self.interactor?.getTopRatedMovies()
        self.interactor?.getUpcomingMovies()
    }
    
    func movieDidSelected(id: Int) {
        if let view = self.view {
            self.router?.openMovieDetailView(from: view, withMovieId: id)
        }
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func updatePopularMovies(_ movies: [Movie]) {
        self.view?.updatePopularMovies(movies)
    }
    
    func updateTopRatedMovies(_ movies: [Movie]) {
        self.view?.updateTopRatedMovies(movies)
    }
    
    func updateUpcomingMovies(_ movies: [Movie]) {
        self.view?.updateUpcomingMovies(movies)
    }
}
