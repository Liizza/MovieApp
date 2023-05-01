//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by user222465 on 10/6/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    var viewModel:MovieCellViewModel? {
        didSet{
            configure()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true

    }
    
    private func configure(){
        voteLabel.text = viewModel?.rating
        guard let posterPath = viewModel?.posterPath else {
            posterImageView.image = UIImage(imageLiteralResourceName: "no-pictures")
            posterImageView.contentMode = .scaleAspectFit
            posterImageView.backgroundColor = .gray
            return
        }
        posterImageView.downloaded(from:"https://image.tmdb.org/t/p/w154\(posterPath)", contentMode: .scaleToFill)
    }
    
}
