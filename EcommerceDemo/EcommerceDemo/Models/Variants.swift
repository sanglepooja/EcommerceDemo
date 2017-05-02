//
//  Variants.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class Variants: Mappable {
    
    var _id : Int?
    var color : String?
    var size : Int?
    var price : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self._id <- map["id"];
        self.color <- map["color"]
        self.size <- map["size"];
        self.price <- map["price"]
        
    }
}
