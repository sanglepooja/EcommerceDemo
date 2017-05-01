//
//  Menu.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class Menu: Mappable {

    var categories : [Category] = []
    var rankings : [Ranking] = []
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        self.rankings <- map["rankings"];
        self.categories <- map["categories"]
    }
}
