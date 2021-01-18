//
//  Utilities.swift
//  marvel_app
//
//  Created by Karol Korzeń on 17/01/2021.
//

import UIKit

class Utilities {
    static let shared = Utilities()
    
    /// func creates  standar label of default size 14 and default weight .back
    /// - Parameters:
    ///   - size: font size
    ///   - weight: weight
    ///   - color: color
    /// - Returns: UILabel
    func standardLabel(withSize size: CGFloat = 14, withWeight weight: UIFont.Weight = .black, withColor color: UIColor = UIColor.rgb(red: 158, green: 158, blue: 158)) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        return label
    }
    
    func standardTextView(withSize size: CGFloat = 14, withWeight weight: UIFont.Weight = .black, withColor color: UIColor = UIColor.rgb(red: 158, green: 158, blue: 158)) -> UITextView {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        return label
    }
    
    /// func creates UIImageView
    /// - Returns: UIImageView
    func thumbnailImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 6
        return iv
    }
}
