//
//  Movie.swift
//  PopularMovies-tvOS
//
//  Created by Austin Potts on 11/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class Movie {
    
    let baseURL = "http://image.tmdb.org/t/p/w500"
    
    var title: String!
    var overview: String!
    var posterPath: String!
    
    init(movieDict: Dictionary<String, AnyObject>){
        if let title = movieDict["title"] as? String {
            self.title = title
        }
        if let overview = movieDict["overview"] as? String {
            self.overview = overview
        }
        if let path = movieDict["poster_path"] as? String {
            self.posterPath = "\(baseURL) \(path)"
        }
    }
}
