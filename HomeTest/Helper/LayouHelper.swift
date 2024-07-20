//
//  LayouHelper.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import Foundation

import UIKit

public struct AnchoredConstraints {
    public var top, leading, left, bottom, trailing, right, centerY, centerX, width, height: NSLayoutConstraint?
}

extension UIView {
    // to not broke the app compatibility
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if let right = right {
            anchoredConstraints.right = rightAnchor.constraint(equalTo: right, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [ anchoredConstraints.top,
          anchoredConstraints.leading,
          anchoredConstraints.left,
          anchoredConstraints.bottom,
          anchoredConstraints.trailing,
          anchoredConstraints.right,
          anchoredConstraints.centerY,
          anchoredConstraints.centerX,
          anchoredConstraints.width,
          anchoredConstraints.height].forEach {
            $0?.isActive = true
        }
        
        return anchoredConstraints
    }
    
    
    @discardableResult
    func fillSuperview(padding: UIEdgeInsets = .zero, safeArea: Bool = false) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = safeArea ? superview?.safeAreaLayoutGuide.topAnchor : superview?.topAnchor,
              let superviewBottomAnchor = safeArea ? superview?.safeAreaLayoutGuide.bottomAnchor : superview?.bottomAnchor,
              let superviewLeadingAnchor = safeArea ? superview?.safeAreaLayoutGuide.leadingAnchor :superview?.leadingAnchor,
              let superviewTrailingAnchor = safeArea ? superview?.safeAreaLayoutGuide.trailingAnchor : superview?.trailingAnchor else {
            return anchoredConstraints
        }
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
}


