//
//  MovieViewCell.swift
//  iOSTest
//
//  Created by David Rivera on 14/11/21.
//

import UIKit

class MovieViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            self.updateMovie()
        }
    }
    
    private func updateMovie() {
        if let url = URL(string: RemoteDataManagerSettings.imageUrl + (self.movie?.posterPath ?? "")) {
            self.posterImageView.load(url: url)
        }
        self.titleLabel.text = self.movie?.title
        self.releaseDateLabel.text = self.movie?.releaseDate
        self.ratingLabel.text = String(format: "%.1f", self.movie?.rating ?? 0)
    }
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
        self.titleLabel.text = nil
        self.releaseDateLabel.text = nil
        super.prepareForReuse()
    }
}
