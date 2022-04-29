//
//  MovieCollectionViewCell.swift
//  Apsiyon
//
//  Created by MERT on 28.04.2022.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var storyImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerView.backgroundColor = .red
    }
    
    func prepareCell(story: MovieModel) {
        self.innerView.layer.cornerRadius = 120.0/2.0
        self.storyImage.layer.cornerRadius = 104.0/2.0
        let url = story.backdropPath
        if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w500/\(url)")!) {
            self.storyImage.image = UIImage(data: data)
        }
        
    }
}

