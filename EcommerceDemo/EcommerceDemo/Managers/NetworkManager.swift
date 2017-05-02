//
//  NetworkManager.swift
//  EcommerceDemo
//
//  Created by Faasos on 01/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    var url:String?
    
    init(url: String) {
        
        super.init()
        self.url = url
        
    }
    
    func apiGet(apiName:String ,completion: @escaping (_ result: AnyObject, _ code:Int) -> Void, failure: @escaping (_ error: NSError, _ code:Int, _ message: String) -> Void) {
        
        let urlEncodedString: String = (self.url?.addingPercentEncoding(withAllowedCharacters: CharacterSet.whitespaces.inverted))!
        
        Alamofire.request(urlEncodedString).responseJSON { response in
            
            switch response.result {
            case .success:
                
                let json = response.result.value
                completion(json as AnyObject,(response.response?.statusCode)!)
                
            case .failure(let error):
                failure(error as NSError, (response.response?.statusCode)!, error.localizedDescription)
            }
        }
    }
}
