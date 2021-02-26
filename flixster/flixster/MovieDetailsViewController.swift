//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by John Smith V on 2/25/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    // Swift optionals is what the exclamation point is called in swift syntax
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        // Getting the general overview for the movie
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        // Getting the movie poster
        let basePosterURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: basePosterURL + posterPath)
        posterView.af.setImage(withURL: posterURL!)
        
        // Getting the movie backdrop
        let baseBackdropURL = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseBackdropURL + backdropPath)
        backdropView.af.setImage(withURL: backdropURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
