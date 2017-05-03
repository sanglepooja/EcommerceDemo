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

class HomeViewController: UIViewController, CategoryDelegate {
    
    var categoryView : CategoryView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let productManager = ProductManager.sharedInstance
        HUD.show(.labeledProgress(title: "Loading...", subtitle: "Please wait"), onView: self.view!)
        
        productManager.apiGetProductsCollection(completion: { arrayCategories in
            
            HUD.hide()
            self.makeCategoryView(categories: arrayCategories)
            
        }) { (error, code, message) in
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Customview methods
    func makeCategoryView(categories:[Category]) {
        
        self.categoryView = CategoryView.init(frame: self.view.bounds, categories: categories)
        self.categoryView?.delegate = self
        self.view.addSubview(self.categoryView!)
    }
    

    //MARK: - Category delegate method
    
    func didSelectCategory(category: Category) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: ProductsViewControllerId) as! ProductsViewController
        controller.category = category
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
}
