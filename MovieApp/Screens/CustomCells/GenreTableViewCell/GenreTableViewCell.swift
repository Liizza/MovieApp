//
//  GenreTableViewCell.swift
//  MovieApp
//
//  Created by user222465 on 10/5/22.
//

import UIKit
import RxSwift
import RxCocoa

class GenreTableViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    var viewModel:GenreCellViewModel? {
        didSet{
            configure()
        }
    }
    @IBOutlet weak var genreLabel:UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
         collectionViewLayout.itemSize = CGSize(width: 100, height:190)
         collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
         collectionViewLayout.scrollDirection = .horizontal
        return collectionViewLayout
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.moviesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at:.left, animated: false)
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            self.accessoryType  = selected ? .checkmark : .none;
    }

    private func configure() {
        genreLabel.text = viewModel?.name
        setUpCollectionView()
        moviesCollectionView.reloadData()
        
    }
    private func setUpCollectionView() {
        guard let viewModel else {
            return
        }
        self.moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        moviesCollectionView.dataSource = nil
        
        moviesCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        
        viewModel.movies.drive(moviesCollectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)){  row, item, cell in
            cell.viewModel = MovieCellViewModel(movie: item)
        }.disposed(by: disposeBag)
        moviesCollectionView.rx.itemSelected.asObservable().bind(to: viewModel.itemSelected.asObserver()).disposed(by: disposeBag)
        
    }
    
    
}


