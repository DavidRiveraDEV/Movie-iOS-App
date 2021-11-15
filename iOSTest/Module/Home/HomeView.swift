//
//  HomeView.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//  
//

import Foundation
import UIKit

class HomeView: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var popularContainerView: UIView!
    @IBOutlet weak var topRatedContainerView: UIView!
    @IBOutlet weak var upcomingContainerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var presenter: HomePresenterProtocol?
    
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        self.presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        
        self.popularContainerView.isHidden = true
        self.topRatedContainerView.isHidden = true
        self.upcomingContainerView.isHidden = true
        
        self.popularCollectionView.delegate = self
        self.popularCollectionView.dataSource = self
        self.popularCollectionView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        
        self.topRatedCollectionView.delegate = self
        self.topRatedCollectionView.dataSource = self
        self.topRatedCollectionView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        
        self.upcomingCollectionView.delegate = self
        self.upcomingCollectionView.dataSource = self
        self.upcomingCollectionView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        
        self.searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showKeyboard)))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
        
        self.searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(self.searchDidChange), for: .editingChanged)

        self.setupScrollView()
    }
    
    private func setupScrollView() {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (note) in
            guard let keyboardFrame = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            self.setScrollViewObttomInset(keyboardFrame.size.height)
        }
        
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { (_) in
            self.setScrollViewObttomInset(0)
        }
    }
    
    private func setScrollViewObttomInset(_ bottomInset: CGFloat) {
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: bottomInset, right: 0.0)
    }
    
    private func showTitle(_ show: Bool) {
        self.titleContainerView.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            self.scrollView.layoutIfNeeded()
            self.titleLabel.alpha = show ? 1 : 0
        }
    }
    
    private func showPopularContainer(_ show: Bool) {
        self.popularContainerView.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            self.scrollView.layoutIfNeeded()
            self.popularCollectionView.alpha = show ? 1 : 0
        }
    }
    
    private func showTopRatedContainer(_ show: Bool) {
        self.topRatedContainerView.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            self.scrollView.layoutIfNeeded()
            self.topRatedContainerView.alpha = show ? 1 : 0
        }
    }
    
    private func showUpcomingContainer(_ show: Bool) {
        self.upcomingContainerView.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            self.scrollView.layoutIfNeeded()
            self.upcomingCollectionView.alpha = show ? 1 : 0
        }
    }
    
    @objc private func showKeyboard() {
        self.searchTextField.becomeFirstResponder()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

extension HomeView: HomeViewProtocol {
    
    func updatePopularMovies(_ movies: [Movie]) {
        self.popularMovies = movies
        DispatchQueue.main.async {
            self.popularCollectionView.reloadData()
            self.showPopularContainer(!movies.isEmpty)
        }
    }
    
    func updateTopRatedMovies(_ movies: [Movie]) {
        self.topRatedMovies = movies
        DispatchQueue.main.async {
            self.topRatedCollectionView.reloadData()
            self.showTopRatedContainer(!movies.isEmpty)
        }
    }
    
    func updateUpcomingMovies(_ movies: [Movie]) {
        self.upcomingMovies = movies
        DispatchQueue.main.async {
            self.upcomingCollectionView.reloadData()
            self.showUpcomingContainer(!movies.isEmpty)
        }
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.popularCollectionView:
            return self.popularMovies.count
        case self.topRatedCollectionView:
            return self.topRatedMovies.count
        case self.upcomingCollectionView:
            return self.upcomingMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as? MovieViewCell {
            var movie: Movie? = nil
            switch collectionView {
            case self.popularCollectionView:
                movie = self.popularMovies[indexPath.row]
            case self.topRatedCollectionView:
                movie = self.topRatedMovies[indexPath.row]
            case self.upcomingCollectionView:
                movie = self.upcomingMovies[indexPath.row]
            default: break
            }
            cell.movie = movie
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie: Movie? = nil
        switch collectionView {
        case self.popularCollectionView:
            movie = self.popularMovies[indexPath.row]
        case self.topRatedCollectionView:
            movie = self.topRatedMovies[indexPath.row]
        case self.upcomingCollectionView:
            movie = self.upcomingMovies[indexPath.row]
        default: break
        }
        if let movie = movie {
            self.presenter?.movieDidSelected(movie: movie)
        }
    }
}

extension HomeView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func searchDidChange() {
        if let text = self.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.presenter?.searchDidChange(text: text)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.showTitle(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showTitle(false)
    }
}
