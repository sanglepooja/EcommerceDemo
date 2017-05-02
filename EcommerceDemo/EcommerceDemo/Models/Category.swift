//
//  Category.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class Category: Mappable {

    var _id : Int?
    var name : String?
    var products : [Product] = []
    var child_categories : [Int] = []
    var categories : [Category] = []
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self._id <- map["id"]
        self.name <- map["name"]
        self.products <- map["products"]
        self.child_categories <- map["child_categories"]
    }
}
    
