//
//  MoviesViewController.swift
//  flixster
//
//  Created by John Smith V on 2/18/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // Creation of a dictonary; the paratheneses mean the dict is initialized
    var movies = [[String: Any]]()
    
    // This is the function that is called as soon as the screen comes up
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              
                // Casting the output of dataDictionary as a Dictionary with type String
                self.movies = dataDictionary["results"] as! [[String: Any]]
            
                self.tableView.reloadData()
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
                print(dataDictionary)
            
            

           }
        }
        task.resume()

    }
    
    // Asking for the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    // For each row, give me the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If another cell is off screen then recycle that; if there aren't any then create more
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        // Accessing the JSON for the title of the movie, so "title"
        let title = movie["title"]
        // ? is called swift optionals -> Need to learn this asap
        //cell.textLabel?.text = title as! String
        cell.titleLabel.text = title as! String
        
        // Getting the synopsis of the movie
        let synoposis = movie["overview"]
        cell.synopsisLabel.text = synoposis as! String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        cell.posterView.af.setImage(withURL: posterURL!)
        
        return cell
    }
    
    

}
