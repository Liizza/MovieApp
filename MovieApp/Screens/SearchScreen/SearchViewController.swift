//
//  SearchViewController.swift
//  MovieApp
//
//  Created by user222465 on 10/13/22.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: BaseViewController {

    var viewModel: SearchViewModelProtocol?
    
    @IBOutlet weak var searchHistoryView: GradientBorderView!
    @IBOutlet weak var searchHistoryTableView: AutomaticHeightTableView!
    @IBOutlet weak var searchResultsTable: UITableView!
    @IBOutlet weak var movieSearchTextField: GradientTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchHistoryView.isHidden = true
        addTapGestureToView()
        movieSearchTextField.addImageView(imageName: "search")
        bindSearchTextField()
        setUpSearchResultTableView()
        setUpSearchHistoryTableView()
    }
    
    func bindSearchTextField() {
        guard let viewModel else { return }
        movieSearchTextField.rx.text.orEmpty.asObservable().bind(to: viewModel.searchTerm).disposed(by: disposeBag)
        movieSearchTextField.rx.controlEvent(.editingDidBegin).asDriver().drive(onNext: {[weak self ] _ in
            guard let self = self else { return }
            self.searchHistoryView.isHidden = false
        }).disposed(by: disposeBag)
        movieSearchTextField.rx.controlEvent(.editingDidEndOnExit).asDriver().drive(onNext: { [weak self]_ in
            viewModel.searchButtonPressed.asObserver().onNext(())
            self?.searchHistoryView.isHidden = true
            self?.movieSearchTextField.text = nil
            self?.movieSearchTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    private func addTapGestureToView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideSearchHistory))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func hideSearchHistory() {
        searchHistoryView.isHidden = true
        movieSearchTextField.resignFirstResponder()
    }
    
    private func setUpSearchResultTableView() {
        guard let viewModel else { return }
        searchResultsTable.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        searchResultsTable.dataSource = nil
        viewModel.movies.drive(searchResultsTable.rx.items(cellIdentifier: "MovieTableViewCell", cellType: MovieTableViewCell.self)) { _, item, cell in
            cell.viewModel = MovieCellViewModel(movie: item)
        }.disposed(by: disposeBag)
        searchResultsTable.rx.itemSelected.asObservable().bind(to: viewModel.movieItemSelected.asObserver()).disposed(by: disposeBag)
    }
    private func setUpSearchHistoryTableView() {
        guard let viewModel else { return }
        searchHistoryTableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        viewModel.searchRequests.drive(searchHistoryTableView.rx.items(cellIdentifier: "SearchHistoryTableViewCell", cellType: SearchHistoryTableViewCell.self)) { _, item, cell in
            cell.configure(searchTerm: item)
        }.disposed(by: disposeBag)
        searchHistoryTableView.rx.itemSelected.asObservable().bind(to: viewModel.searchHistoryItemSelected.asObserver()).disposed(by: disposeBag)
    }
}
