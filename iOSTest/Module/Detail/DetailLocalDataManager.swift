//
//  DetailLocalDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation

class DetailLocalDataManager {
    
    var dataManagerRequestHandler: DetailLocalDataManagerOutputProtocol?
    
    let localMovieService: LocalMovieService
    
    init() {
        self.localMovieService = LocalMovieService()
    }
}

extension DetailLocalDataManager: DetailLocalDataManagerInputProtocol {
    
    func getMovie(id: Int) {
        self.localMovieService.getMovie(id: id) { [weak self] movie in
            self?.dataManagerRequestHandler?.onMovieSuccess(movie)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onMovieError(response)
        }
    }    
}
