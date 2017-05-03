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
    
    var arrayRootCategories : [Category] = []
    var arrayAllCategories : [Category] = []
    
    func apiGetProductsCollection(completion: @escaping (_ categories : [Category]) -> Void, failure: @escaping (_ error: NSError, _ code:Int, _ message: String) -> Void) {
        
        let networkManager = NetworkManager(url: PRODUCTS_URL)
        
        networkManager.apiGet(apiName: "GET PRODUCTS", completion: { (response, message) in
            
            let menu = Mapper<Menu>().map(JSON: response as! [String : Any])! as Menu
            print(menu as Menu)
            
            self.manageAllCategoriesMapping(categories: menu.categories)
            self.findRootCategories()
            self.mapRankingsWithCategoryProducts(rankings: menu.rankings)
        
            completion(self.arrayRootCategories)
        
        }) { (error, code, message) in
            
            failure(error, code, message)
        }
    }
    
    
    func manageAllCategoriesMapping(categories : [Category]) -> Void {
        
        for category in categories {
         
            let allChildCategories = self.getAllMappedChildCategories(category: category, fromCategorySet: categories)
            
            for childCategory in allChildCategories {
                
                if !category.categories.contains(where: {
                    
                    $0._id == childCategory._id
                }) {
                    
                    category.categories.append(contentsOf: allChildCategories)
                }
                
            }
            
            self.arrayAllCategories.append(category)
        }
        
    }
    
    
    func getAllMappedChildCategories(category: Category, fromCategorySet allCategories: [Category]) -> [Category] {
        
        var arrayWithChildCategories : [Category] = []
        
        if !category.child_categories.isEmpty {
            
            for categoryId in category.child_categories {
                
                let arrayChildCategories = allCategories.filter (){
                    
                    $0._id == categoryId
                }
                
                if !arrayChildCategories.isEmpty {
                    
                    for childCategory in arrayChildCategories {
                        
                       let allChildCategories = getAllMappedChildCategories(category: childCategory, fromCategorySet: allCategories)
                        
                        childCategory.categories.append(contentsOf: allChildCategories)
                    }
                    
                }
                
                arrayWithChildCategories.append(contentsOf: arrayChildCategories)
            }
            
            return arrayWithChildCategories
        }
        
        return []
    }
    
    func findRootCategories() -> Void {
        
        for category in arrayAllCategories {
            
            let arrayTemp = arrayAllCategories.filter() {
                
                $0.child_categories.contains(category._id!)
            }
            
            if arrayTemp.isEmpty {
                
                self.arrayRootCategories.append(category)
            }
            
        }
    }
    
    func mapRankingsWithCategoryProducts(rankings: [Ranking]) -> Void {
        
        
        for ranking in rankings {
            
            self.searchProductAndMapRanking(arrayCategory: self.arrayRootCategories, ranking: ranking)
        }
    }
    
    func searchProductAndMapRanking(arrayCategory:[Category], ranking: Ranking) -> Void {
        
        for category in arrayCategory {
            
            if !category.products.isEmpty {
                
                for product in ranking.products {
                    
                    let productArray = category.products.filter() {
                        
                        $0._id == product._id
                    }
                    
                    if !productArray.isEmpty {
                        
                        let actualProduct = productArray.first
                        switch ranking.ranking! {
                        case .MostOrdeRedProducts:
                            
                            actualProduct?.order_count = product.order_count
                            break
                        case .MostShaRedProducts:
                            
                            actualProduct?.shares = product.shares
                            break
                            
                        case .MostViewedProducts:
                            
                            actualProduct?.view_count = product.view_count
                            break
                            
                        }
                    }
                }
            } else if !category.categories.isEmpty {
                
                searchProductAndMapRanking(arrayCategory: category.categories, ranking: ranking)
            }
        }
    }
}
