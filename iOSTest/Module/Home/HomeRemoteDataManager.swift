//
//  HomeRemoteDataManager.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation

class HomeRemoteDataManager: HomeDataManager {
    
    init() {
        super.init(movieService: RemoteMovieService())
    }
}
