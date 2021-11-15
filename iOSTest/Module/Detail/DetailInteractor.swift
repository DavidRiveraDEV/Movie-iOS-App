//
//  DetailInteractor.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation

class DetailInteractor: DetailInteractorInputProtocol {

    weak var presenter: DetailInteractorOutputProtocol?
    var localDatamanager: DetailLocalDataManagerInputProtocol?
    var remoteDatamanager: DetailRemoteDataManagerInputProtocol?
    
    private var movieId: Int = 0
    private var category: Category?
    
    private var loadingMovieRemotely: Bool = false
    
    func getMovie(id: Int, withCategory category: Category) {
        self.movieId = id
        self.category = category
        self.loadingMovieRemotely = true
        self.remoteDatamanager?.getMovie(id: id)
    }
}

extension DetailInteractor: DetailLocalDataManagerOutputProtocol, DetailRemoteDataManagerOutputProtocol {
    
    func onMovieSuccess(_ movieResponse: Movie) {
        self.loadingMovieRemotely = false
        self.presenter?.updateMovie(movieResponse)
    }
    
    func onMovieError(_ response: FailedResponse) {
        if self.loadingMovieRemotely {
            self.loadingMovieRemotely = false
            self.localDatamanager?.getMovie(id: movieId)
        } else {
            self.presenter?.updateMovie(Movie())
        }
    }
}
