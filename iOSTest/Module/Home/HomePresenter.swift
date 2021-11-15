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
    
    var lastSearchText: String = ""
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        self.interactor?.getPopularMovies()
        self.interactor?.getTopRatedMovies()
        self.interactor?.getUpcomingMovies()
    }
    
    func movieDidSelected(movie: Movie) {
        if let view = self.view {
            self.router?.openMovieDetailView(from: view, withMovieId: movie.id, andCategory: Category(rawValue: movie.category!)!)
        }
    }
    
    func searchDidChange(text: String) {
        if self.lastSearchText != text {
            self.lastSearchText = text
            if (text.isEmpty) {
                self.viewDidLoad()
            } else {
                self.interactor?.getPopularMoviesFiltered(value: text)
                self.interactor?.getTopRatedMoviesFiltered(value: text)
                self.interactor?.getUpcomingMoviesFiltered(value: text)
            }
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
