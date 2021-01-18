//
//  SearchController.swift
//  marvel_app
//
//  Created by Karol Korzeń on 14/01/2021.
//

import UIKit

private let reuseIdentifier = "searchcell"

class SearchController: UICollectionViewController {
    // MARK: - Properties
    
    private var viewModel = ComicsViewModel() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var infoSearchLabel = Utilities.shared.standardLabel(withSize: 18, withWeight: .medium, withColor: UIColor.rgb(red: 38, green: 36, blue: 36))
    private var bookImage = Utilities.shared.thumbnailImageView()
    var stack = UIStackView()
    let loading = Utilities.shared.thumbnailImageView()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers

    func configureUI(){
        collectionView.backgroundColor = .white
        collectionView.register(ComicCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(bookImage)
        view.addSubview(infoSearchLabel)
        
        bookImage.image = UIImage(named: "book-open_icon")
        bookImage.setDimensions(width: 80, height: 62)
        
        infoSearchLabel.text = "Start typing to find particular comics."
        infoSearchLabel.numberOfLines = 0
        infoSearchLabel.textAlignment = .center
        
        stack = UIStackView.init(arrangedSubviews: [bookImage, infoSearchLabel])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        stack.center(inView: view)
        
        view.addSubview(loading)
        loading.image = UIImage(named: "loader_icon")
        loading.center(inView: view)
        loading.rotate()
        loading.isHidden = true
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a comic book"
        searchController.searchBar.tintColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        let searchBarStyle = searchController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .never
        navigationItem.searchController = searchController
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.layer.borderWidth = 0.50
        navigationController?.navigationBar.layer.borderColor = UIColor.clear.cgColor
        navigationController?.navigationBar.clipsToBounds = true
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension SearchController {
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

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-32, height: 184)
    }
}

//MARK: - UISearchResultsUpdating

extension SearchController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.replacingOccurrences(of: " ", with: "+") else {return}
        if searchText == "" {
            let label = self.stack.subviews.last as! UILabel
            label.text = "Start typing to find particular comics."
            stack.isHidden = false
            self.collectionView.isHidden = true
        } else {
            stack.isHidden = true
            DispatchQueue.main.async {
                self.loading.isHidden = false
                self.collectionView.isHidden = true
                self.viewModel.searchComics(withPhrase: searchText) {numberOfFindings in
                    self.loading.isHidden = true
                    if numberOfFindings == 0 {
                        let label = self.stack.subviews.last as! UILabel
                        label.text = "There is no comic book \"\(searchController.searchBar.text!)\" in our library. Check the spelling and try again."
                        self.stack.isHidden = false
                        self.collectionView.isHidden = true
                    } else {
                        self.stack.isHidden = true
                        self.collectionView.isHidden = false
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}
