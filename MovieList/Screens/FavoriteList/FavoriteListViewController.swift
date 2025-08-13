//
//  FavoriteListViewController.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 9.07.2025.
//

import UIKit

protocol FavoriteListViewProtocol {
    func showFavorities(list: [String])
    func showEmptyMessage()
}

class FavoriteListViewController: BaseViewController, FavoriteListViewProtocol {
    
    var favoriMovies: [String] = []
    var presenter: FavoriteListPresenterProtocol?
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tableView.backgroundColor = .black

        title = "Favorite Movies"
        
        tableView.rowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteListCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .gray
        presenter?.viewFavoriteList()
        
        navigationItem.hidesBackButton = false
    }
    
    func showFavorities(list: [String]) {
        favoriMovies = list
        tableView.reloadData()
    }
    
    func showEmptyMessage() {
        if favoriMovies.isEmpty == true {
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Your list is empty", message: "Please add a movie to your favorite list", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    deinit {
    }
    
}
extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteListCell
        
        let text = favoriMovies[indexPath.row]
        
        cell.configure(text: text)
        
        cell.backgroundColor = .black
        
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") {_, _, completion in
            
            guard self.favoriMovies.indices.contains(indexPath.row) else {
                      completion(false)
                      return
                  }
            
                  self.favoriMovies.remove(at: indexPath.row)
                  self.presenter?.removeFavoriteList(at: indexPath.row)
                  self.tableView.beginUpdates()
                  self.tableView.deleteRows(at: [indexPath], with: .automatic)
                  self.tableView.endUpdates()

                  completion(true)
        }
        delete.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [delete])
    }
}
