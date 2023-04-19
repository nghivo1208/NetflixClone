//
//  APICaller.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 06/04/2023.
//

import Foundation

struct Constants {

    static let API_KEY = "6b3a15cbd04591c7db045b165553b07e"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyCRPVhCR1RHmgCDoFNcaRW7CQtGgehkmR0"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3"
}

enum APIError: Error{
    case failedToGetData
}

class APICaller{
    static let share = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
//                let result0 = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            
            guard let data = data, error == nil else {return}
            
            do{
//                let result0 = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(result0)
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1")else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-U&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponde.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getMovies(with query: String, completion: @escaping (Result<videoElement, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)/search?q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else{return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
            }catch{
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
}



