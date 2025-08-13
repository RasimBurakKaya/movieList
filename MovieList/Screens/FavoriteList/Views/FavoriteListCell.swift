//
//  FavoriteListCell.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 18.07.2025.
//

import UIKit

class FavoriteListCell: UITableViewCell {
    
    private let movieTitle: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    override init(style: UITableViewCell.CellStyle,
                    reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          contentView.addSubview(movieTitle)

          NSLayoutConstraint.activate([
              movieTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
              movieTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
              movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
              movieTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
          ])
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        movieTitle.text = text
    }
    

}
