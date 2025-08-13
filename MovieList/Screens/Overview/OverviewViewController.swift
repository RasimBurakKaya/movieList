//
//  OverviewViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 8.07.2025.
//

import UIKit

protocol OverviewViewProtocol: AnyObject {
    func updateFavoriteIcon(_ isFavorite: Bool)
}

class OverviewViewController: UIViewController, OverviewViewProtocol {
    
    var movie: Movie?
    var presenter: OverviewPresenterProtocol?
    
    @IBOutlet weak var topRButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var favMovieButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.favoriteDidChange()
     
    }
    
    func setupUI(){
        title = "Movie Detail"

        guard let movie = movie else { return }
              
        titleLabel.text = movie.original_title
              
        overviewLabel.text = movie.overview
 
        let urlString = "https://image.tmdb.org/t/p/w500\(movie.poster_path)"

        imageView.setImage(url: urlString,
                                 placeholder: UIImage(named: "placeholder"))
        
        imageView.contentMode = .scaleAspectFit
    }
 
    @IBAction func topRatedMoviesButton(_ sender: UIButton) {
        presenter?.showMovieList()
    }
    
    @IBAction func profileButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToProfileFromOverview", sender: nil)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        presenter?.favoriteDidTap()
        
    }
    
    func updateFavoriteIcon(_ isFavorite: Bool) {
        if isFavorite == true {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func favMoviesButtonTapped(_ sender: UIButton) {
   
        presenter?.showFavoritiesTapped()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToProfileFromOverview" {
            let destinationVC = segue.destination as? ProfileViewController
            destinationVC?.text = presenter?.getUserName()
        }
    }
    
}
