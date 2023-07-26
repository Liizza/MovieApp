//
//  GenresViewViewModel.swift
//  MovieApp
//
//  Created by user222465 on 11/9/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol GenresViewModelProtocol {
    var genres: Driver<[Genre]> { get }
    func viewModelForGenreCell(for genre: Genre?) -> GenreCellViewModel?
}

class GenresViewViewModel: GenresViewModelProtocol {
    var apiService: ApiService?
    
    private let disposeBag = DisposeBag()
    let didOpenMovieController = PublishSubject<MovieProtocol?>()
    private let _genres = BehaviorRelay<[Genre]>(value: [])
    var genres: Driver<[Genre]> {
        return _genres.asDriver()
    }
    
    init(apiService: ApiService?) {
        self.apiService = apiService
        self.getGenres()
    }
    func getGenres() {
        apiService?.genresApiService.getGenresOfMovies { result in
            switch result {
            case .failure(let error):
                print("Error : \(error)")
            case .success(let results):
                self._genres.accept(results)
            }
        }
    }
    func viewModelForGenreCell(for genre: Genre?) -> GenreCellViewModel? {
        guard let genre else { return nil }
        let viewModel = GenreCellViewModel(genre: genre, apiService: apiService?.genresApiService)
        viewModel.didMovieSelected.asObservable().bind(to: didOpenMovieController.asObserver()).disposed(by: disposeBag)
        return viewModel
    }
}
