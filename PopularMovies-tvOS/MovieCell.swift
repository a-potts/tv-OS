//
//  MovieCell.swift
//  PopularMovies-tvOS
//
//  Created by Austin Potts on 11/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabe: UILabel!
    
    func configureCell(movie: Movie){
        
        if let title = movie.title {
            movieLabe.text = title
            
        }
        if let path = movie.posterPath{
            let url = NSURL(string: path)!
            
            DispatchQueue.global(qos: .background).async {
                let data = NSData(contentsOf: url as URL)!
                DispatchQueue.main.async {
                    let image = UIImage(data: data as Data)
                    self.movieImage.image = image
                }
            }
        }
        
    }
    
}
