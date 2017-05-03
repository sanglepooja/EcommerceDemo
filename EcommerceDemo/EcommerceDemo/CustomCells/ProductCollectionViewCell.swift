//
//  ProductCollectionViewCell.swift
//  EcommerceDemo
//
//  Created by Faasos on 04/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    
    @IBOutlet weak var labelProductPrice: UILabel!
    
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
