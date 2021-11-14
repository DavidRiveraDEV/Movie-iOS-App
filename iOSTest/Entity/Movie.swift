//
//  Movie.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//

import Foundation
import SwiftUI
import RealmSwift

class Movie: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var overview: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var popularity: Float = 0
    @objc dynamic var posterPath: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var category: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case category
    }
}

enum Category: String, Codable {
    case popular
    case topRated
    case upcoming
}
