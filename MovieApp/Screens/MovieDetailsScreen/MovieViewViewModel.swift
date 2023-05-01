//
//  MovieViewViewModel.swift
//  MovieApp
//
//  Created by user222465 on 11/8/22.
//

import Foundation
import RxSwift
import RxCocoa
class MovieViewViewModel {
    
    private let apiService: ApiService?
    private var movie:MovieProtocol
    
    private let disposeBag = DisposeBag()
    private let _videos = BehaviorRelay<[Video]>(value:[])
    private let _ifSuccess = BehaviorRelay<Bool>(value: false)
    
    let addToFavoritesButtonPressed = PublishSubject<Void>()
    
    var ifSuccess: Driver<Bool> {
        return _ifSuccess.asDriver()
    }
    var videos: Driver<[Video]> {
        return _videos.asDriver()
    }
    var title: String {
        return movie.title
    }
    var posterPath: String? {
        return movie.posterPath
    }
    var description: String {
        return movie.overview
    }
    var id: Int {
        return movie.id
    }
    var rating:String {
        return "⭐️ \(movie.voteAverage)"
    }
    
   
    
    init(movie:MovieProtocol, apiService: ApiService?) {
        self.apiService = apiService
        self.movie = movie
        loadVideo()
        self.addToFavoritesButtonPressed.asObservable()
            .subscribe(onNext:{ [weak self] in
                self?.addToFavourites()}).disposed(by: disposeBag)
    }
    private func loadVideo(){
        self._videos.accept([])
        apiService?.movieApiService.getMovieVideos(movieId: movie.id){
            [weak self] response in
            switch response{
            case .failure(let error):
                print(error)
            case .success(let results):
                self?._videos.accept(results)
                
            }
            
        }
        
        
    }
    private func addToFavourites(){
        apiService?.movieApiService.postAddFavoriteMovie(movieId:movie.id, mark: true){ [weak self] response in
            switch response {
            case .failure(let error):
                print(error)
                self?._ifSuccess.accept(false)
            case .success(_):
                print("add to favorites")
                self?._ifSuccess.accept(true)
                
                
            }
            
        }
        
    }
}
