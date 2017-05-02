//
//  HomeViewController.swift
//  EcommerceDemo
//
//  Created by Faasos on 01/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import ObjectMapper
import PKHUD

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let productManager = ProductManager.sharedInstance
        HUD.show(.labeledProgress(title: "Loading...", subtitle: "Please wait"), onView: self.view!)
        
        productManager.apiGetProductsCollection(completion: { arrayCategories in
            
            HUD.hide()
            
        }) { (error, code, message) in
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
