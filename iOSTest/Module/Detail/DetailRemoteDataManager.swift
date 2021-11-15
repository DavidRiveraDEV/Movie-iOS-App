//
//  DetailRemoteDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation

class DetailRemoteDataManager {
    
    var dataManagerRequestHandler: DetailRemoteDataManagerOutputProtocol?
    
    let remoteMovieService: RemoteMovieService
    
    init() {
        self.remoteMovieService = RemoteMovieService()
    }
}

extension DetailRemoteDataManager: DetailRemoteDataManagerInputProtocol {
    
    func getMovie(id: Int) {
        self.remoteMovieService.getMovie(id: id) { [weak self] movie in
            self?.dataManagerRequestHandler?.onMovieSuccess(movie)
        } onFailed: { [weak self] response in
            self?.dataManagerRequestHandler?.onMovieError(response)
        }
    }
}
