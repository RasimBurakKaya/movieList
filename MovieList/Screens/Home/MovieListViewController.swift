//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import UIKit

protocol MovieListViewProtocol: AnyObject{
    func showMovies(movies: [Movie])
}

class MovieListViewController: UIViewController {
    
    var presenter: MovieListPresenterProtocol?
    
    var movies: [Movie] = []
    
    var image = UIImage()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func topRatedMoviesButton(_ sender: UIButton) {
    }
    
    
    @IBAction func profileButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "fromMLtoProfile", sender: nil)

    }
    
    private func profileImageKey(for uid: String) -> String {
        return "profileImageData_\(uid)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        presenter?.viewDidload()
        
        title = "Top Rated Movies"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        let name = presenter?.userName ?? ""
        titleLabel.text = "Welcome \(name)"
        
        titleLabel.textColor = .white
        
        navigationItem.hidesBackButton = true

    }

}
extension MovieListViewController: MovieListViewProtocol {
    func showMovies(movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
    
}
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieListTableViewCell
        
        let movie = movies[indexPath.row]
        
        cell.backgroundColor = .black
        
        cell.configure(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        
        presenter?.navigate(movie: movie)
       
        //performSegue(withIdentifier: "goToOverview", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* if segue.identifier == "goToOverview"{
            let destinationVC = segue.destination as! OverviewViewController
            
            if let indexPath = sender as? IndexPath {
                destinationVC.movie = movies[indexPath.row]
            }
        }*/ if segue.identifier == "fromMLtoProfile" {
            let destinationVC = segue.destination as! ProfileViewController
            destinationVC.text = presenter?.userName
        }
        
    }
    
}
