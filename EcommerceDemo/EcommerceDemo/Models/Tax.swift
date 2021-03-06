//
//  Tax.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class Tax: Mappable {
    
    var name : String?
    var value : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.name <- map["name"];
        self.value <- map["value"]
    }
}
