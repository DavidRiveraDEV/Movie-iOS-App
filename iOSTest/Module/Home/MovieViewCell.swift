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
        if let posterPath = self.movie?.posterPath {
            if let cacheImage = ImageCacheService.getImage(forKey: posterPath) {
                self.posterImageView.image = cacheImage
            } else if let url = URL(string: RemoteDataManagerSettings.imageUrl + posterPath) {
                self.posterImageView.load(url: url) { image in
                    if let image = image {
                        ImageCacheService.save(image: image, forKey: posterPath)
                    }
                }
            }
        }
        self.titleLabel.text = self.movie?.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self.movie?.releaseDate ?? "") {
            dateFormatter.dateFormat = "yyyy"
            self.releaseDateLabel.text = dateFormatter.string(from: date)
        }
        self.ratingLabel.text = String(format: "%.1f", self.movie?.rating ?? 0)
    }
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
        self.titleLabel.text = nil
        self.releaseDateLabel.text = nil
        super.prepareForReuse()
    }
}
