//
//  HomeController.swift
//  marvel_app
//
//  Created by Karol Korzeń on 14/01/2021.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "comiccell"

class HomeController: UICollectionViewController {
    
    // MARK: - Properties
    
    let viewModel = ComicsViewModel()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Marvel Comics"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.layer.borderWidth = 0.50
        navigationController?.navigationBar.layer.borderColor = UIColor.clear.cgColor
        navigationController?.navigationBar.clipsToBounds = true
        fetchComics()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
    }
    
    // MARK: - API
    
    func fetchComics(){
        viewModel.fetchComics {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Helpers
    
    func configureUI(){
        collectionView.register(ComicCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
}

// MARK: - UICollectionViewDelegate/DataSource

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfComics
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ComicCell
        cell.viewModel = ComicViewModel(withComic: viewModel.comics[indexPath.row])
        cell.shadowDecorate()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsController(withViewModel: ComicViewModel(withComic: viewModel.comics[indexPath.row]))
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-32, height: 184)
    }
}
 
