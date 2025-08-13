//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 4.07.2025.
//

import UIKit

protocol cellProtocol: AnyObject {
    func cellImage(image: UIImage)
    func cellDate(dateLabel: UILabel)
    func cellTitle(titleLabel: UILabel)
    func cellVote(voteLabel: UILabel)
}

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellReleaseDateLabel: UILabel!
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var cellVoteLabel: UILabel!
    
    weak var cellDelegate: cellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(_ movie: Movie) {
        cellImageView.setImage(url: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
        cellVoteLabel.text = "⭐️ \(movie.vote_average)"
        cellTitleLabel.text = movie.original_title
        cellReleaseDateLabel.text = "Release Date: \(movie.release_date)"
        
        cellVoteLabel.textColor = .white
        cellTitleLabel.textColor = .white
        cellReleaseDateLabel.textColor = .white
        
        
    }
    
}
extension MovieListTableViewCell: cellProtocol {
    func cellVote(voteLabel: UILabel) {
        cellVoteLabel.text = voteLabel.text
    }
    
    func cellTitle(titleLabel: UILabel) {
        cellTitleLabel.text = titleLabel.text
    }
    
    func cellDate(dateLabel: UILabel) {
        cellReleaseDateLabel.text = dateLabel.text
    }
    
    func cellImage(image: UIImage) {
        cellImageView.image = image
    }
    
    
}
