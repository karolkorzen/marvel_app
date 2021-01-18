//
//  ComicViewModel.swift
//  marvel_app
//
//  Created by Karol Korzeń on 17/01/2021.
//

import Foundation

class ComicViewModel {
    
    //MARK: - Properties
    
    private var comic: Comic
    
    //MARK: - Lifecycle
    
    init(withComic comic: Comic) {
        self.comic = comic
    }
    
    //MARK: - Helpers
    
    var titleLabelText: String {
        return comic.title
    }
    
    var writerLabelText: String {
        var writers = String()
        for item in comic.creators.items.enumerated() {
            if item.element.role == "writer" {
                writers.append(item.element.name)
                writers.append(", ")
            }
        }
        if writers.count>2 {
            writers.removeLast(2)
            return "written by \(writers)"
        } else {
            return "writer not known"
        }
    }
    
    var descriptionLabelText: String {
        guard let desc = comic.description else {return ""}
        return desc
    }
    
    var thumbnailPhotoUrl: URL {
        guard let url = URL(string: comic.thumbnail.path+"/portrait_uncanny.jpg") else {return URL(string: "")!}
        return url
    }
    
    var comicLink: URL {
        for item in comic.urls {
            if item.type == "detail" {
                return URL(string: item.url)!
            }
        }
        return URL(string: "")!
    }
}
