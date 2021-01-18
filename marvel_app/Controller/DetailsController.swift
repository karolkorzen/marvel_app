//
//  DetailsController.swift
//  marvel_app
//
//  Created by Karol Korzeń on 14/01/2021.
//

import UIKit
import FloatingPanel
import SDWebImage

class DetailsController: UIViewController {
    
    //MARK: - Properties
    
    let viewModel: ComicViewModel
    let fpc = FloatingPanelController()
    
    let comicImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let findMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find out more", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .red
        button.layer.cornerRadius = 6
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(findMoreClicked), for: .touchUpInside)
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: -10)
        button.layer.shadowRadius = 20
        button.layer.shadowOpacity = 0.88
        return button
    }()
    
    let whiteLabel: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.backgroundColor = .white
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(withViewModel viewModel: ComicViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setFloatingPanel()
    }
    
    //MARK: - Selectors
    
    @objc func findMoreClicked(){
        UIApplication.shared.open(viewModel.comicLink)
    }

    //MARK: - Helpers
    
    func configureNavBar(){
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector_arrow_back"), style: .plain, target: self, action: #selector(popNavBar))
        backBarButtonItem.tintColor = UIColor.rgb(red: 38, green: 36, blue: 36)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationItem.title = "Details"
    }
    
    @objc func popNavBar(){
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI(){
        view.addSubview(comicImage)
        comicImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        comicImage.layer.zPosition = -1
        comicImage.sd_setImage(with: viewModel.thumbnailPhotoUrl)
        
        view.addSubview(findMoreButton)
        findMoreButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 15, paddingBottom: 24, paddingRight: 15, height: 52)
        
        view.addSubview(whiteLabel)
        whiteLabel.anchor(top: findMoreButton.bottomAnchor, left: findMoreButton.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: findMoreButton.rightAnchor)
    }
    
    func setFloatingPanel() {
        fpc.delegate = self
        let descriptionView = DescriptionView(withViewModel: self.viewModel)
        fpc.set(contentViewController: descriptionView)
        fpc.layout = MyStatsFloatingPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.surfaceView.appearance.cornerRadius = 35
    }
}

extension DetailsController: FloatingPanelControllerDelegate {
    
}

class MyStatsFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 300.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
