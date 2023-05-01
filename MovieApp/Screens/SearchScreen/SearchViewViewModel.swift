//
//  SearchViewViewModel.swift
//  MovieApp
//
//  Created by user222465 on 11/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewViewModel {
    
    private let apiService:ApiService?
    private let disposeBag = DisposeBag()
    
    private let _movies = BehaviorRelay<[MovieProtocol]>(value: [])
    private let _searchRequests = BehaviorRelay<[String]>(value: [])
    private var arrayOfSearchRequest:[String] = []
    
    var movies:Driver<[MovieProtocol]>{
        return _movies.asDriver()
    }
    var searchRequests:Driver<[String]>{
        return _searchRequests.asDriver()
    }
    
    let searchHistoryItemSelected = PublishSubject<IndexPath>()
    let searchButtonPressed = PublishSubject<Void>()
    var searchTerm = BehaviorRelay<String>(value: "")
    let movieItemSelected = PublishSubject<IndexPath>()
    let didOpenMovieController = PublishSubject<MovieProtocol?>()
    

    init(apiService:ApiService?) {
        self.apiService = apiService
        
        bind()
        
    }
    private func bind() {
        searchHistoryItemSelected.asObservable().subscribe(onNext:{ [weak self] indexPath in
            guard let searchTerm = self?.searchTermForIndex(index: indexPath.row) else {
                return
            }
            self?.arrayOfSearchRequest.remove(at: indexPath.row)
            self?.getMovies(searchTerm: searchTerm)
        }).disposed(by: disposeBag)
        
        movieItemSelected.asObservable().map({[weak self] indexPath in
            return self?.movieForIndex(index: indexPath.row)
        }).bind(to:didOpenMovieController).disposed(by: disposeBag)
        
        searchButtonPressed.asObservable().subscribe(onNext: {[weak self] _ in
            guard let self = self else{
                return
            }
            if !self.searchTerm.value.isEmpty {
                self.getMovies(searchTerm: self.searchTerm.value)
            }
        }).disposed(by: disposeBag)
    }
    private func getMovies(searchTerm:String) {
        arrayOfSearchRequest.insert(searchTerm, at: 0)
        if arrayOfSearchRequest.count > 10 {
            _searchRequests.accept(Array(arrayOfSearchRequest[0...10]))
        }
        _searchRequests.accept(arrayOfSearchRequest)
        
        apiService?.searchApiService.getSearchResults(searchTerm: searchTerm) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let searchResults):
                self?._movies.accept(searchResults)
            
            }
            
        }
        
    }
    private func movieForIndex(index:Int) -> MovieProtocol? {
        guard index < _movies.value.count else {
            return nil
        }
        return _movies.value[index]
        
    }
    
    private func searchTermForIndex(index:Int) -> String? {
        guard index < _searchRequests.value.count else {
            return nil
        }
        return _searchRequests.value[index]
    }
    
    
}
