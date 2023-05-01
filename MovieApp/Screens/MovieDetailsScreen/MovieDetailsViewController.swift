//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by user222465 on 10/13/22.
//

import UIKit
import youtube_ios_player_helper
import RxSwift
import RxCocoa
import RxGesture
import Lottie

class MovieDetailsViewController: BaseViewController, YTPlayerViewDelegate {

    @IBOutlet weak var addToFavoritesButton: GradientButton!
    
    
    @IBOutlet weak var movieVideoPlayer: YTPlayerView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionOfMovieLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel:MovieViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func setUp(){
        guard let viewModel else {
            return
        }
        self.ratingLabel.text = viewModel.rating
        self.descriptionOfMovieLabel.text = viewModel.description
        self.titleLabel.text = viewModel.title
        guard let posterPath = viewModel.posterPath else {
            posterImageView.image = UIImage(imageLiteralResourceName: "no-pictures")
            posterImageView.contentMode = .scaleAspectFit
            posterImageView.backgroundColor = .gray
            return
        }
        
        posterImageView.downloaded(from: "https://image.tmdb.org/t/p/original\(posterPath)")
        
        viewModel.videos.drive(onNext:{[weak self] videos in
            if !videos.isEmpty {
                self?.movieVideoPlayer.load(withVideoId: "\(videos[0].key)")
            }
        }).disposed(by: disposeBag)
        
       self.addToFavoritesButton.rx
            .tap
            .asObservable()
            .bind(to: viewModel.addToFavoritesButtonPressed.asObserver())
            .disposed(by: disposeBag)
        
    }
    
}
