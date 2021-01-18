//
//  MarvelService.swift
//  marvel_app
//
//  Created by Karol Korzeń on 14/01/2021.
//

import UIKit

class MarvelService {
    static let shared = MarvelService()
    private var dataTask: URLSessionDataTask?
    private static let hash_key = "6edc18ab1a954d230c1f03c590d469d2"
    static let api_key = "080a502746c8a60aeab043387a56eef0"
    
    /// function fetches 25 comics for home sccene
    /// - Parameter completion: Comics
    func fetchComics(completion: @escaping((RawComicsResponse) -> Void)){
        
        let fetchLink = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=\(MarvelService.api_key)&hash=\(MarvelService.hash_key)&limit=25&offset=0"
        print("DEBUG: fetchLink -> \(fetchLink)")
        guard let url = URL(string: fetchLink) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RawComicsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch let error {
                print("ERROR!!!")
                print(error)
            }
            
        }
        dataTask?.resume()
    }
    
    /// function searches comics with phrase given
    /// - Parameters:
    ///   - phrase: searching title
    ///   - completion: Comics
    func searchComics(withPhrase phrase: String, completion: @escaping ((RawComicsResponse) -> Void)) {
        
        let searchLink = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=\(MarvelService.api_key)&hash=\(MarvelService.hash_key)&limit=25&offset=0&title=\(phrase)"
        
        print("DEBUG: search link \(searchLink)")
        
        guard let url = URL(string: searchLink) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RawComicsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch let error {
                print("ERROR!!!")
                print(error)
            }
            
        }
        dataTask?.resume()
    }
}
