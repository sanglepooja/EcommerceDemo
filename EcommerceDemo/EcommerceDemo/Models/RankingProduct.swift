//
//  RankingProduct.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class RankingProduct: Mappable {

    var _id : Int?
    var view_count : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self._id <- map["id"];
        self.view_count <- map["view_count"]
    }
}
