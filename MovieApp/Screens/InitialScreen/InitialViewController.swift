//
//  ViewController.swift
//  MovieApp
//
//  Created by user222465 on 10/4/22.
//

import UIKit
import Lottie
import RxSwift
import RxCocoa

class InitialViewController: BaseViewController {
    var viewModel: InitialViewModelProtocol?
    lazy var loadingView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("loading")
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.checkIfLogin()
        addLoadingAnimation()
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
