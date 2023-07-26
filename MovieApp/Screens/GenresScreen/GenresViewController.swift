//
//  GenresViewController.swift
//  MovieApp
//
//  Created by user222465 on 10/5/22.
//

import UIKit
import RxSwift
import RxCocoa

class GenresViewController: BaseViewController {

    @IBOutlet weak var genresTableView: UITableView!
    
    var viewModel: GenresViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpTableView() {
        guard let viewModel else { return }
        genresTableView.register(UINib(nibName: "GenreTableViewCell", bundle: nil), forCellReuseIdentifier: "GenreTableViewCell")
        genresTableView.dataSource = nil
        viewModel.genres.drive(genresTableView.rx.items(cellIdentifier: "GenreTableViewCell", cellType: GenreTableViewCell.self)) { _, item, cell in
            cell.viewModel = viewModel.viewModelForGenreCell(for: item)
        }.disposed(by: disposeBag)
    }
}
