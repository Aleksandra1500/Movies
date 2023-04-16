//
//  MovieDetailsDataSource.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import Foundation
import Alamofire


struct MovieDetailsDataSource {
    let apiKey: String
    let baseUrl: String

    init(apiKey: String, baseUrl: String) {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }

    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsDto, Error>) -> Void) {
        let url = URL(string: baseUrl + "/movie/\(movieId)")!
        let parameters = ["api_key": apiKey, "language": "en-US", "append_to_response": "credits,similar"] as [String : Any]

        AF.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(_):
                let decoder: JSONDecoder = JSONDecoder()
                if let data = response.data {
                    do {
                        let movie = try decoder.decode(MovieDetailsDto.self, from: data)
                        completion(.success(movie))
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
