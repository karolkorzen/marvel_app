//
//  ComicViewModel.swift
//  marvel_app
//
//  Created by Karol Korzeń on 17/01/2021.
//

import Foundation

class ComicsViewModel {
    
    //MARK: - Properties
    
    var comics: [Comic] = []
    
    //MARK: - Lifecycle
    
    //MARK: - API
    
    func fetchComics(completion:(@escaping()->Void)){
        MarvelService.shared.fetchComics { (response) in
            self.comics = response.data.results
            completion()
        }
    }
    
    func searchComics(withPhrase phrase: String, completion:(@escaping(Int)->Void)){
        MarvelService.shared.searchComics(withPhrase: phrase) { (response) in
            self.comics = response.data.results
            completion(self.comics.count)
        }
    }
    
    //MARK: - Helpers
    
    var numberOfComics: Int {
        return comics.count
    }
}
