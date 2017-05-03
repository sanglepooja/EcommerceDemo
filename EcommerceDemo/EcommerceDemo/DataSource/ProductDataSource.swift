//
//  ProductDataSource.swift
//  EcommerceDemo
//
//  Created by Faasos on 04/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit

class ProductDataSource: NSObject {

    var product : Product?
    var price : Int?
    var size : Int?
    var color : String?
    var view_count : Int?
    var order_count : Int?
    var shares : Int?
    
    init(varient: Variants, product: Product) {
        
        self.product = product
        self.price = varient.price != nil ? varient.price: 0
        self.color = varient.color != nil ? varient.color: ""
        self.size = varient.size != nil ? varient.size: 0
        self.view_count = product.view_count != nil ? product.view_count: 0
        self.order_count = product.order_count != nil ? product.order_count: 0
        self.shares = product.shares != nil ? product.shares: 0
    }
    
    
}
