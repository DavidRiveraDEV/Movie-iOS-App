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
    
    func saveMovie(_ movie: Movie) -> Bool {
        do {
            self.clearMovie(id: movie.id)
            try self.realm?.write() {
                self.realm?.add(movie)
            }
            return true
        } catch {
            return false
        }
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
        if let movie: Movie = self.realm?.objects(Movie.self).filter("id == %@", id).first {
            onSuccess(movie)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
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
    
    func getPopularMoviesFiltered(value: String, onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let movies: [Movie] = self.realm?.objects(Movie.self).filter("category == %@ AND title CONTAINS[c] %@", Category.popular.rawValue, value).compactMap({ $0 }) {
            let moviesResponse = MoviesResponse(movies: movies)
            onSuccess(moviesResponse)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
        
    }
    
    func getTopRatedMoviesFiltered(value: String, onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let movies: [Movie] = self.realm?.objects(Movie.self).filter("category == %@ AND title CONTAINS[c] %@", Category.topRated.rawValue, value).compactMap({ $0 }) {
            let moviesResponse = MoviesResponse(movies: movies)
            onSuccess(moviesResponse)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
    }
    
    func getUpcomingMoviesFiltered(value: String, onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        if let movies: [Movie] = self.realm?.objects(Movie.self).filter("category == %@ AND title CONTAINS[c] %@", Category.upcoming.rawValue, value).compactMap({ $0 }) {
            let moviesResponse = MoviesResponse(movies: movies)
            onSuccess(moviesResponse)
        } else {
            onFailed(FailedResponse(statusCode: .internalServerError, description: "Realm error", details: nil))
        }
    }
    
    func clearMovie(id: Int) {
        if let realm = realm {
            try? realm.write {
                realm.delete(realm.objects(Movie.self).filter("id == %@", id))
            }
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
