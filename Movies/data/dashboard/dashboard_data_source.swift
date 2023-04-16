//
//  dashboard_data_source.swift
//  ios_films
//
//  Created by Mateusz Filipek on 14/04/2023.
//

import Foundation
import Alamofire


struct DashboardDataSource {
    let apiKey: String
    let baseUrl: String

    init(apiKey: String, baseUrl: String) {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }

    func getTopRatedMovies(page: Int, completion: @escaping (Result<[BasicMovieDto], Error>) -> Void) {
        let url = URL(string: baseUrl + "/movie/top_rated")!
        let parameters = ["api_key": apiKey, "language": "en-US", "page": page] as [String : Any]

        AF.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let decoder: JSONDecoder = JSONDecoder()
                if let data = response.data {
                    do {
                        // LIST OF MOVIES IS UNDER "results" KEY
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        // under "results" key there is an array of movies (each movie is a dictionary)
                        var movies: [BasicMovieDto] = []
                        for movie in json["results"] as! [[String: Any]] {
                            // each movie is a dictionary
                            // we need to convert it to json
                            let jsonData = try JSONSerialization.data(withJSONObject: movie, options: [])
                            // and then decode it to BasicMovieDto
                            let movie = try decoder.decode(BasicMovieDto.self, from: jsonData)
                            movies.append(movie)
                        }                        
                        
                        completion(.success(movies))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPopularMovies(page: Int, completion: @escaping (Result<[BasicMovieDto], Error>) -> Void) {
        let url = baseUrl + "/movie/popular"
        let parameters = ["api_key": apiKey, "language": "en-US", "page": page] as [String : Any]

        AF.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let decoder: JSONDecoder = JSONDecoder()
                if let data = response.data {
                    do {
                        // LIST OF MOVIES IS UNDER "results" KEY
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        // under "results" key there is an array of movies (each movie is a dictionary)
                        var movies: [BasicMovieDto] = []
                        for movie in json["results"] as! [[String: Any]] {
                            // each movie is a dictionary
                            // we need to convert it to json
                            let jsonData = try JSONSerialization.data(withJSONObject: movie, options: [])
                            // and then decode it to BasicMovieDto
                            let movie = try decoder.decode(BasicMovieDto.self, from: jsonData)
                            movies.append(movie)
                        }                        
                        
                        completion(.success(movies))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[BasicMovieDto], Error>) -> Void) {
        let url = baseUrl + "/movie/now_playing"
        let parameters = ["api_key": apiKey, "language": "en-US", "page": page] as [String : Any]

        AF.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let decoder: JSONDecoder = JSONDecoder()
                if let data = response.data {
                    do {
                        // LIST OF MOVIES IS UNDER "results" KEY
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        // under "results" key there is an array of movies (each movie is a dictionary)
                        var movies: [BasicMovieDto] = []
                        for movie in json["results"] as! [[String: Any]] {
                            // each movie is a dictionary
                            // we need to convert it to json
                            let jsonData = try JSONSerialization.data(withJSONObject: movie, options: [])
                            // and then decode it to BasicMovieDto
                            let movie = try decoder.decode(BasicMovieDto.self, from: jsonData)
                            movies.append(movie)
                        }                        
                        
                        completion(.success(movies))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUpcomingMovies(page: Int, completion: @escaping (Result<[BasicMovieDto], Error>) -> Void) {
        let url = baseUrl + "/movie/upcoming"
        let parameters = ["api_key": apiKey, "language": "en-US", "page": page] as [String : Any]

        AF.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let decoder: JSONDecoder = JSONDecoder()
                if let data = response.data {
                    do {
                        // LIST OF MOVIES IS UNDER "results" KEY
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        // under "results" key there is an array of movies (each movie is a dictionary)
                        var movies: [BasicMovieDto] = []
                        for movie in json["results"] as! [[String: Any]] {
                            // each movie is a dictionary
                            // we need to convert it to json
                            let jsonData = try JSONSerialization.data(withJSONObject: movie, options: [])
                            // and then decode it to BasicMovieDto
                            let movie = try decoder.decode(BasicMovieDto.self, from: jsonData)
                            movies.append(movie)
                        }                        
                        
                        completion(.success(movies))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
