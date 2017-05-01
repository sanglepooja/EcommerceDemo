//
//  ProductManager.swift
//  EcommerceDemo
//
//  Created by Faasos on 02/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductManager: NSObject {

    static let sharedInstance = ProductManager()
    
    func apiGetProducts() -> [Product] {
        
        let arrayProducts : [Product] = []
        
        let networkManager = NetworkManager(url: PRODUCTS_URL)
        
        networkManager.apiGet(apiName: "GET PRODUCTS", completion: { (response, message) in
            
            let menu = Mapper<Menu>().map(JSON: response as! [String : Any])! as Menu
            
            
            
        }) { (error, code, message) in
            
            
        }
        
        return arrayProducts
    }
    
}
