//
//  search_data_source.swift
//  Movies
//
//  Created by Mateusz Filipek on 21/04/2023.
//

import Foundation
import Alamofire

struct SearchDataSource {
    let apiKey: String
    let baseUrl: String

    init(apiKey: String, baseUrl: String) {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }

    func searchForMovies(query: String, page: Int, completion: @escaping (Result<[BasicMovieDto], Error>) -> Void) {
        let url = URL(string: baseUrl + "/search/movie")!
        let parameters = ["api_key": apiKey, "query": query, "language": "en-US", "page": page] as [String : Any]

        
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
