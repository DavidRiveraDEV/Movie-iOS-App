//
//  DetailView.swift
//  iOSTest
//
//  Created by David Rivera on 15/11/21.
//  

import Foundation
import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var presenter: DetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.presenter?.viewDidLoad()
    }
    
    @IBAction func onBackButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailView: DetailViewProtocol {
    
    func updateMovie(_ movie: Movie) {
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate ?? "") {
            dateFormatter.dateFormat = "yyyy"
            self.releaseDateLabel.text = dateFormatter.string(from: date)
        }
        self.ratingLabel.text = String(format: "%.1f", movie.rating)
        if let backdropPath = movie.backdropPath {
            if let cacheImage = ImageCacheService.getImage(forKey: backdropPath) {
                self.backdropImageView.image = cacheImage
            } else if let url = URL(string: RemoteDataManagerSettings.imageUrl + backdropPath) {
                self.backdropImageView.load(url: url) { image in
                    if let image = image {
                        ImageCacheService.save(image: image, forKey: backdropPath)
                    }
                }
            }
        }
        if let posterPath = movie.posterPath {
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
    }
}
