//
//  Extensions.swift
//  marvel_app
//
//  Created by Karol Korzeń on 16/01/2021.
//

import UIKit

extension UIView {
    
    /// func allows to set layout for view
    /// - Parameters:
    ///   - top: top anchor
    ///   - left: left anchor
    ///   - bottom: bottom anchor
    ///   - right: right anchor
    ///   - paddingTop: distance from top anchor
    ///   - paddingLeft: distance from left anchor
    ///   - paddingBottom: distance from bottom anchor
    ///   - paddingRight: distance from right anchor
    ///   - width: width of view
    ///   - height: height of view
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    /// function centers object in view in X and Y axis
    /// - Parameters:
    ///   - view: view that we center in
    ///   - yConstant: offset for height
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    
    /// function centers object in view in X axis
    /// - Parameters:
    ///   - view: view that we center in
    ///   - topAnchor: topAnchor of that view
    ///   - paddingTop: distance from topAnchor
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    /// function centers object in view in Y axis
    /// - Parameters:
    ///   - view: view that we center in
    ///   - leftAnchor: leftAnchor of that view
    ///   - paddingLeft: distance from leftAnchor
    ///   - constant: offset for height
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    /// function sets dimensions for object
    /// - Parameters:
    ///   - width: width of object
    ///   - height: height of object
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// function sets all anchors for object same as for view
    /// - Parameter view: view in which we are filling view
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

extension UIColor {
    
    /// func creates UIColor from mix of red, green and blue
    /// - Parameters:
    ///   - red: red colour (1-255)
    ///   - green: green colour (1-255)
    ///   - blue: blue colour (1-255)
    /// - Returns: UIColor
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UICollectionViewCell {
    /// Call this method from `prepareForReuse`, because the cell needs to be already rendered (and have a size) in order for this to work
    func shadowDecorate(radius: CGFloat = 8,
                        shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08),
                        shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                        shadowRadius: CGFloat = 24,
                        shadowOpacity: Float = 1) {
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
}
