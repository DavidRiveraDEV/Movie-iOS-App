//
//  LocalMovieService.swift
//  iOSTest
//
//  Created by David Rivera on 13/11/21.
//

import Foundation
import RealmSwift

class LocalMovieService {
    
    let realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
    
    func saveMovies(_ movies: [Movie]) -> Bool {
        guard !movies.isEmpty else { return false }
        do {
            try self.realm?.write() {
                movies.forEach { self.realm?.add($0) }
            }
            return true
        } catch {
            return false
        }
    }
    
    func getMovie(id: Int, onSuccess: @escaping (_ movie: Movie) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        
    }
    
    func getPopularMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let movies: [Movie] = self.realm?.objects(Movie.self).filter("category == %@", Category.popular.rawValue).compactMap({ $0 }) {
            let moviesResponse = MoviesResponse(movies: movies)
            onSuccess(moviesResponse)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
        
    }
    
    func getTopRatedMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let movies: [Movie] = self.realm?.objects(Movie.self).filter("category == %@", Category.topRated.rawValue).compactMap({ $0 }) {
            let moviesResponse = MoviesResponse(movies: movies)
            onSuccess(moviesResponse)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
    }
    
    func getUpcomingMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let movies: [Movie] = self.realm?.objects(Movie.self).filter("category == %@", Category.upcoming.rawValue).compactMap({ $0 }) {
            let moviesResponse = MoviesResponse(movies: movies)
            onSuccess(moviesResponse)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
    }
    
    func clearPopularMovies() {
        if let realm = realm {
            try? realm.write {
                realm.delete(realm.objects(Movie.self).filter("category == %@", Category.popular.rawValue))
            }
        }
    }
    
    func clearTopRatedMovies() {
        if let realm = realm {
            try? realm.write {
                realm.delete(realm.objects(Movie.self).filter("category == %@", Category.topRated.rawValue))
            }
        }
    }
    
    func clearUpcomingMovies() {
        if let realm = realm {
            try? realm.write {
                realm.delete(realm.objects(Movie.self).filter("category == %@", Category.upcoming.rawValue))
            }
        }
    }
}
