//
//  Network.swift
//  MoviesApplication
//
//  Created by Mehmet Baturay Yasar on 23/06/2022.
//

import Foundation

enum HttpMethod:String {
    case post = "POST"
    case get = "GET"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getLanguages(completion: @escaping([String], Bool) -> ()){
        let header = [
            "X-RapidAPI-Key": "4d0d5ea12cmsh428363f07a05d6bp1a6fd8jsnc7eaa04c8974",
            "X-RapidAPI-Host": "ott-details.p.rapidapi.com"
        ]
        
        if let url = URL(string: "https://ott-details.p.rapidapi.com/getParams?param=language") {
            var urlRequest = URLRequest(url: url, timeoutInterval: 30)
            
            urlRequest.httpMethod = HttpMethod.get.rawValue
            urlRequest.allHTTPHeaderFields = header
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    //alert will be added.
                }
                
                if data != nil {
                    do{
                        if let data = data{
                            let decoder = JSONDecoder()
                            let model = try decoder.decode([String].self, from: data)
                            completion(model, true)
                        }
                    }catch {
                        print(error)
                        completion([],false)
                    }
                }
            }
            task.resume()
        }
            
    }
    
    func getFilmList(language:String,completiton:@escaping (Movie?,Bool) -> ()){
        let header = [
            "X-RapidAPI-Key":"155d2168bbmshc6d6702ed9fa1e4p1e1a44jsnee4d94fb2f76",
            "X-RapidAPI-Host":"ott-details.p.rapidapi.com"
        ]
        
        if let url = URL(string: "https://ott-details.p.rapidapi.com/advancedsearch?language=\(language)") {
            var urlRequest = URLRequest(url: url , timeoutInterval: 30)
            
            urlRequest.httpMethod = HttpMethod.get.rawValue
            urlRequest.allHTTPHeaderFields = header
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    // Alert eklenecek
                }
                if data != nil {
                    do {
                        if let data = data {
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(Movie.self, from: data)
                            completiton(model,true)
                        }
                    }catch {
                        print(error)
                        completiton(nil,false)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
}
