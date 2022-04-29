//
//  MovieDetailViewController.swift
//  Apsiyon
//
//  Created by MERT on 28.04.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var movieName: UILabel!
    
    
    //MARK: Properties
    var selectedMovie = MovieModel(JSON: ["" : ""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareUI()
    }
    func prepareUI() {
        self.movieName.text = self.selectedMovie?.title
    }
    

}
