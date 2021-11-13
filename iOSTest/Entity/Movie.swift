//
//  Movie.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//

import Foundation

struct Movie: Codable {
    
    var id: Int
    var title: String
    var overview: String
    var status: String
    var releaseDate: String
    var popularity: Float
    var posterPath: String?
    var backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case status
        case releaseDate = "release_date"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
