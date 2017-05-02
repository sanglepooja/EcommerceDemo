//
//  Ranking.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

enum RankingType:String {
    case MostShaRedProducts = "Most ShaRed Products"
    case MostOrdeRedProducts = "Most OrdeRed Products"
    case MostViewedProducts = "Most Viewed Products"
}

class Ranking: Mappable {

    var ranking : RankingType?
    var products : [RankingProduct] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        self.ranking <- map["ranking"]
        self.products <- map["products"]
    }
}
