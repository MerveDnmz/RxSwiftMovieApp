//
//  Webservice.swift

import Foundation

public enum movieError : Error {
    case serverError
    case parsingEror
}

class Webservice {
    
    func downloadMovieList(url: URL, completion: @escaping (Result<[ListResult],movieError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                let result = try? JSONDecoder().decode(MovieSearchModel.self, from: data)
                let movieList = result?.search
                
                if let movieList = movieList {
                    completion(.success(movieList))
                } else {
                    completion(.failure(.parsingEror))
                }
                
            }
            
        }.resume()
        
    }
    
    
    func downloadMovie(url: URL, completion: @escaping (Result<MovieDetailModel,movieError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                let movie = try? JSONDecoder().decode(MovieDetailModel.self, from: data)
                    
                if let movie = movie {
                    completion(.success(movie))
                } else {
                    completion(.failure(.parsingEror))
                }
                
            }
            
        }.resume()
        
    }
    
}
