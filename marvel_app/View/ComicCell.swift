//
//  ComicCell.swift
//  marvel_app
//
//  Created by Karol Korzeń on 17/01/2021.
//

import UIKit
import SDWebImage

class ComicCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: ComicViewModel? {
        didSet {
            putData()
        }
    }
    
    private lazy var thumbnailImageView = Utilities.shared.thumbnailImageView()
    private var titleLabel = Utilities.shared.standardLabel(withSize: 18, withWeight: .medium, withColor: UIColor.rgb(red: 38, green: 36, blue: 36))
    private var writerLabel = Utilities.shared.standardLabel(withSize: 11, withWeight: .regular, withColor: UIColor.rgb(red: 196, green: 196, blue: 196))
    private var descriptionLabel = Utilities.shared.standardLabel(withSize: 13, withWeight: .regular, withColor: UIColor.rgb(red: 38, green: 36, blue: 36))
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        backgroundColor = .white
        layer.cornerRadius = 6
        descriptionLabel.setLineHeight(lineHeight: 18)
        descriptionLabel.numberOfLines = 0
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(writerLabel)
        addSubview(descriptionLabel)
        
        thumbnailImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, width: 121)
        titleLabel.anchor(top: topAnchor, left: thumbnailImageView.rightAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 16, height: 17)
        writerLabel.anchor(top: titleLabel.bottomAnchor, left: thumbnailImageView.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, height: 13)
        descriptionLabel.anchor(top: writerLabel.bottomAnchor, left: thumbnailImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 12)
        
    }
    
    func putData(){
        guard let viewModel = viewModel else {return}
//        thumbnailImageView.sd_setImage(with: viewModel.thumbnailPhotoUrl, placeholderImage: nil, options: .allowInvalidSSLCertificates)
        thumbnailImageView.sd_setImage(with: viewModel.thumbnailPhotoUrl)
        titleLabel.text = viewModel.titleLabelText
        writerLabel.text = viewModel.writerLabelText
        descriptionLabel.text = viewModel.descriptionLabelText
    }
    
}
