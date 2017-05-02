//
//  Product.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: Mappable {
    
    var _id : Int?
    var name : String?
    var date_added : String?
    var variants : [Variants] = []
    var tax : Tax?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self._id <- map["id"];
        self.name <- map["name"]
        self.date_added <- map["date_added"];
        self.tax <- map["tax"]
        self.variants <- map["variants"];
        
    }
}


