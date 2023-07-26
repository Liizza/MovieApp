//
//  FavoritesViewViewModel.swift
//  MovieApp
//
//  Created by user222465 on 11/9/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritesViewModelProtocol {
    var movies: Driver<[MovieProtocol]> { get }
    var isLoading: Driver<Bool> { get }
    var itemSelected: PublishSubject<IndexPath> { get }
    var movieDeleted: PublishSubject<IndexPath> { get }
    func loadMovies()
}

class FavoritesViewViewModel: FavoritesViewModelProtocol {
    private let apiService: ApiService?
    private var repository: Repository?
    
    private let disposeBag = DisposeBag()
    private let _movies = BehaviorRelay<[MovieProtocol]>(value: [])
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    var movies: Driver<[MovieProtocol]> {
        return _movies.asDriver()
    }
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver()
    }
    private var numberOfMovies: Int {
        return _movies.value.count
    }
    let itemSelected = PublishSubject<IndexPath>()
    let didOpenMovieController = PublishSubject<MovieProtocol?>()
    let movieDeleted = PublishSubject<IndexPath>()
    
    init(apiService: ApiService?) {
        self.apiService = apiService
        self.repository = RealmRepository(apiService: apiService)
        bind()
    }
    
    private func bind() {
        itemSelected.asObservable().map({ [weak self] indexPath in
            self?.movieForIndex(index: indexPath.row)
        }).bind(to: didOpenMovieController).disposed(by: disposeBag)
        movieDeleted.asObservable().subscribe(onNext: { [weak self ] indexPath in
            self?.deleteMovie(at: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    func loadMovies() {
        self._movies.accept([])
        self._isLoading.accept(true)
        repository?.getMovie { [weak self] results in
                self?._isLoading.accept(false)
                self?._movies.accept(results)
        }
    }
    private func deleteMovie(at index: Int) {
        apiService?.favoritesApiService.postDeleteFromFavorites(movieId: _movies.value[index].id, mark: false) { [weak self] results in
            switch results {
            case .failure(let error):
            print(error)
            case .success(_):
                self?.loadMovies()
            }
        }
    }
    private func movieForIndex(index: Int) -> MovieProtocol? {
        guard index < _movies.value.count else { return nil }
        return _movies.value[index]
    }    
}
