//
//  MovieTableViewCell.swift
//  Apsiyon
//
//  Created by MERT on 28.04.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    @IBOutlet weak var imdbScore: UILabel!
    
    //MARK: Properties
    var isLoading = false
    var movieMainController = MovieViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareCell(movie: MovieModel) {
        self.innerView.layer.cornerRadius = 12
        self.innerView.addShadow(radius: 12)
        self.filmName.text = movie.title
        self.filmYear.text = movie.release_date
        self.imdbScore.text = "\(movie.voteAverage ?? 0) / 10 "
        let url = movie.backdropPath
        if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w500/\(url)")!) {
            self.filmImage.image = UIImage(data: data)
        }
        
        if (movie.voteAverage ?? 0.0) > 7.0  {
            self.imdbScore.textColor = .green
        }else if (movie.voteAverage ?? 0.0) > 6.0 && (movie.voteAverage ?? 0.0) < 7.0 {
            self.imdbScore.textColor = .orange
        }else {
            self.imdbScore.textColor = .red
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async {
                    // Fake background loading task for 2 seconds
                    sleep(2)
            
                    DispatchQueue.main.async {
                        self.movieMainController.tableView.reloadData()
                        self.isLoading = false
                    }
                }
            }
        }
}
