//
//  FavoritesTableViewCell.swift
//  MovieApp
//
//  Created by user222465 on 10/13/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var viewModel: MovieCellViewModelProtocol? {
        didSet {
            configure()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func configure() {
        titleLabel.text = viewModel?.title
        ratingLabel.text = viewModel?.rating
        guard
            let posterPath = viewModel?.posterPath
        else {
            posterImageView.image = UIImage(imageLiteralResourceName: "no-pictures")
            posterImageView.contentMode = .scaleAspectFit
            posterImageView.backgroundColor = .gray
            return
        }
        posterImageView.downloaded(from: "https://image.tmdb.org/t/p/w154\(posterPath)")
    }   
}
