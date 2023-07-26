//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by user222465 on 10/13/22.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class FavoritesViewController: BaseViewController {
    var viewModel: FavoritesViewModelProtocol?
    
    @IBOutlet weak var favoritesTableView: UITableView!
    lazy var loadingView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("loading")
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.loadMovies()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addLoading()
    }
    
    private func setUpTableView() {
        guard let viewModel else { return }
        favoritesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        viewModel.movies.drive(favoritesTableView.rx.items(cellIdentifier: "MovieTableViewCell", cellType: MovieTableViewCell.self)) { _, item, cell in
            cell.viewModel = MovieCellViewModel(movie: item)
        }.disposed(by: disposeBag)
        favoritesTableView.rx.itemDeleted.asObservable().bind(to: viewModel.movieDeleted.asObserver()).disposed(by: disposeBag)
        favoritesTableView.rx.itemSelected.asObservable().bind(to: viewModel.itemSelected.asObserver()).disposed(by: disposeBag)
    }
    
    private func addLoading() {
        viewModel?.isLoading.drive(onNext: { [weak self] isLoading in
            if isLoading {
                self?.addLoadingAnimation()
            } else {
                self?.loadingView.removeFromSuperview()
            }
        }).disposed(by: disposeBag)
    }
    
    private func addLoadingAnimation() {
        self.view.addSubview(loadingView)
        loadingView.play()
        let centerX = loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerY = loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let height = loadingView.heightAnchor.constraint(equalToConstant: 100)
        let width = loadingView.widthAnchor.constraint(equalTo: loadingView.heightAnchor, multiplier: 1)
        NSLayoutConstraint.activate([centerX, centerY, height, width])
    }
}
