//
//  RemoteMovieService.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//

import Foundation

class RemoteMovieService {
    
    private var httpClient: HTTPClientProtocol
    
    init() {
        let logger = BasicLogger(String(describing: RemoteMovieService.self))
        let httpService = AlamofireHTTPService(with: logger)
        self.httpClient = HTTPClient(baseUrl: RemoteDataManagerSettings.baseUrl, httpService: httpService)
    }
    
    func getMovie(id: Int, onSuccess: @escaping (_ movie: Movie) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.httpClient.get(apiPath: RemoteDataManagerSettings.moviePath, pathParams: ["id" : id], queryParams: ["api_key" : RemoteDataManagerSettings.apiKey], headers: nil, onSuccessful: onSuccess, onFailed: onFailed)
    }
    
    func getPopularMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.httpClient.get(apiPath: RemoteDataManagerSettings.popularMoviesPath, pathParams: nil, queryParams: ["api_key" : RemoteDataManagerSettings.apiKey], headers: nil, onSuccessful: onSuccess, onFailed: onFailed)
    }
    
    func getTopRatedMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.httpClient.get(apiPath: RemoteDataManagerSettings.topRatedMoviesPath, pathParams: nil, queryParams: ["api_key" : RemoteDataManagerSettings.apiKey], headers: nil, onSuccessful: onSuccess, onFailed: onFailed)
    }
    
    func getUpcomingMovies(onSuccess: @escaping (_ moviesResponse: MoviesResponse) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.httpClient.get(apiPath: RemoteDataManagerSettings.upcomingMoviesPath, pathParams: nil, queryParams: ["api_key" : RemoteDataManagerSettings.apiKey], headers: nil, onSuccessful: onSuccess, onFailed: onFailed)
    }
}
