//
//  File.swift
//  testHttpreq
//
//  Created by ABD on 14/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import Foundation
import UIKit


class ImgItemCell: UICollectionViewCell {
    
    // this will be our "call back" action
    var btnTapAction : (()->())?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    let editButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Edit", for: .normal)
        return button
    }()
    
    func setupViews(){
        
        // add a button
        addSubview(editButton)
        
        editButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        // add the touchUpInside target
        editButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
    }
    
    @objc func btnTapped() {
        print("Tapped!")
        
        // use our "call back" action to tell the controller the button was tapped
        btnTapAction?()
    }
    
}

