//
//  MoviesResponse.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//

import Foundation

struct MoviesResponse: Codable {
    
    var page: Int?
    var totalPages: Int?
    var totalMovies: Int?
    var movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalMovies = "total_results"
        case movies = "results"
    }
}
