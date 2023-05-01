//
//  GenreCellViewModel.swift
//  MovieApp
//
//  Created by user222465 on 11/9/22.
//

import Foundation
import RxCocoa
import RxSwift

class GenreCellViewModel {
    
    private let genre: Genre
    
    private let disposeBag = DisposeBag()
    private let apiService: GenresApiService?
    
    var name: String {
        return genre.name
    }
    private var id: Int {
        return genre.id
    }
    
    private let _movies = BehaviorRelay<[MovieProtocol]>(value: [])
    let itemSelected = PublishSubject<IndexPath>()
    let didMovieSelected = PublishSubject<MovieProtocol?>()
    
    var movies: Driver<[MovieProtocol]> {
        return _movies.asDriver()
    }
    private var numberOfMovies: Int {
        return _movies.value.count
    }
    
    init(genre:Genre, apiService:GenresApiService?) {
        self.genre = genre
        self.apiService = apiService
        getMovies()
        itemSelected.asObservable().map({[weak self] indexPath in
            self?.movieForIndex(index: indexPath.item)
        }).bind(to: didMovieSelected.asObserver()).disposed(by: disposeBag)
        
    }
    
    private func getMovies(){
        apiService?.getMoviesByGenre(genreID:id) { [weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let results):
                self?._movies.accept(results)
            }
        }
    }
    
    private func movieForIndex(index:Int) -> MovieProtocol? {
        guard index < numberOfMovies else {
            return nil
        }
        return _movies.value[index]
        
    }
    
}
