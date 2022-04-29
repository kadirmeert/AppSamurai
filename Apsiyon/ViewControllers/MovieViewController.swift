//
//  MovieViewController.swift
//  Apsiyon
//
//  Created by MERT on 28.04.2022.
//
import Alamofire
import AlamofireObjectMapper
import UIKit

class MovieViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var story: UIView!
    @IBOutlet weak var imageStory: UIImageView!
    
    //MARK: Properties
    
    var movieList = [MovieModel]()
    var yourViewBorder = CAShapeLayer()
    var storyList = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getMovieList()
    }
    func getMovieList() {
        
        Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=bd7847090fea4f76f5ce0c22bd1a85b8", method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: nil).responseObject{(response: DataResponse<MovieResponseModel>) in
            
            if let movieResponse = response.result.value {
                self.movieList = movieResponse.results
                self.storyList = movieResponse.results
                self.tableView.reloadData()
                self.collectionView.reloadData()
            } else {
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? MovieDetailViewController {
                if let movie = sender as? MovieModel {
                    detailVC.selectedMovie = movie
                }
            }
        }
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let storyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! MovieCollectionViewCell
        let selectedMovie = self.storyList[indexPath.item]
        storyCell.prepareCell(story: selectedMovie)
        return storyCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.story.isHidden = false
        let image = self.storyList[indexPath.item]
        let url = image.backdropPath
        if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w500/\(url)")!) {
            self.imageStory.image = UIImage(data: data)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.story.isHidden = true
        }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let selectedMovie = self.movieList[indexPath.item]
        movieCell.prepareCell(movie: selectedMovie)
        return movieCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = self.movieList[indexPath.item]
        self.performSegue(withIdentifier: "showDetail" , sender: selectedMovie)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}





