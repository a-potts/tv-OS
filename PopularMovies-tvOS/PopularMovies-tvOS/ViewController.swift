//
//  ViewController.swift
//  PopularMovies-tvOS
//
//  Created by Austin Potts on 11/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    let baseURL = "http://api.themoviedb.org/3/movie/popular?api_key=ff743742b3b6c89feb59dfc138b4c12f"
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    var movies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func downloadData(){
        let url = URL(string: baseURL)!
        let request = URLRequest(url: url as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) ->
            Void in
            
            if let error = error {
                print(error)
            } else {
                do{
                    let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict!["results"] as? [Dictionary<String, AnyObject>] {
                        
                        for obj in results {
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        
                        //Main UI Thread
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    }
                    
                } catch {
                    
                }
            }
            
        }
        
        task.resume()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            
            let movie = movies[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        } else {
        
        return MovieCell()
        }
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 649, height: 851) 
    }
    
}

