//
//  HeaderView.swift
//  EcommerceDemo
//
//  Created by Faasos on 03/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit

protocol HeaderDelegate {
    func didTapSectionAtIndex(index: Int)
}

class HeaderView: UIView {
    
    var delegate : HeaderDelegate?
    
    var index : Int?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HeaderView.tapHeaderView(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapHeaderView(sender: AnyObject) -> Void {
        
        delegate?.didTapSectionAtIndex(index: index!)
    }

}
