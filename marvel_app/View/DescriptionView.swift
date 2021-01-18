//
//  DescriptionView.swift
//  marvel_app
//
//  Created by Karol Korzeń on 17/01/2021.
//

import UIKit

class DescriptionView: UIViewController {
    
    //MARK: - Properties
    
    let viewModel: ComicViewModel
    private var titleLabel = Utilities.shared.standardLabel(withSize: 18, withWeight: .medium, withColor: UIColor.rgb(red: 38, green: 36, blue: 36))
    private var writerLabel = Utilities.shared.standardLabel(withSize: 14, withWeight: .regular, withColor: UIColor.rgb(red: 196, green: 196, blue: 196))
    private var descriptionLabel = Utilities.shared.standardTextView(withSize: 16, withWeight: .regular, withColor: UIColor.rgb(red: 38, green: 36, blue: 36))
    
    //MARK: - Lifecycle
    
    init(withViewModel viewModel: ComicViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(writerLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 15, paddingRight: 15, height: 15)
        writerLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 11, paddingLeft: 15, paddingRight: 15, height: 15)
        descriptionLabel.anchor(top: writerLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 9, paddingLeft: 15, paddingBottom: 30, paddingRight: 15)
        
        titleLabel.text = viewModel.titleLabelText
        writerLabel.text = viewModel.writerLabelText
        descriptionLabel.text = viewModel.descriptionLabelText
    }
}
