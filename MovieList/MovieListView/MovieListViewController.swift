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
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidload()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

}
extension MovieListViewController: MovieListViewProtocol {
    func showMovies(movies: [Movie]) {
        <#code#>
    }
    
    
}
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
