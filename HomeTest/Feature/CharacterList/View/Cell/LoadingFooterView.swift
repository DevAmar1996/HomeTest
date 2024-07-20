//
//  LoadingFooterView.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import UIKit


class LoadingFooterView: UIView, NibLoadable {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view = loadViewFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
