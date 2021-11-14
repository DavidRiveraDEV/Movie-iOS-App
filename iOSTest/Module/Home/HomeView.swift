//
//  HomeView.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation
import UIKit

class HomeView: UIViewController {
    
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension HomeView: HomeViewProtocol {
    
    func updatePopularMovies(_ movies: [Movie]) {
        print("MOVIESTEST", "popular", movies)
    }
    
    func updateTopRatedMovies(_ movies: [Movie]) {
        print("MOVIESTEST", "topRated", movies)
    }
    
    func updateUpcomingMovies(_ movies: [Movie]) {
        print("MOVIESTEST", "upcoming", movies)
    }
}
