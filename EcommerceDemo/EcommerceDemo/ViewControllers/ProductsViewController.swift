//
//  ProductsViewController.swift
//  EcommerceDemo
//
//  Created by Faasos on 04/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView:UICollectionView = {
        
        var cv:UICollectionView = UICollectionView(frame:CGRect(x: 0, y: 110, width: self.view.frame.size.width, height: self.view.frame.size.height - 110), collectionViewLayout: self.flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        
        return cv
    }()
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        
        var flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(1.0,1.0, 1.0, 1.0)
        flow.itemSize = self.view.frame.size
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.scrollDirection = .vertical
        
        return flow
    }()
    
    var category : Category?
    var arrayDataSource : [ProductDataSource] = []
    
    @IBOutlet weak var buttonViews: UIButton!
    @IBOutlet weak var buttonOrderCount: UIButton!
    @IBOutlet weak var buttonShares: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
        
        let nibName = UINib(nibName: "ProductCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: ProductCollectionViewCellId)

        self.title = self.category?.name
        makeDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func updateSortUI(sortType: RankingType) -> Void {
        
        switch sortType {
        case .MostShaRedProducts:
            
            self.buttonShares.setTitleColor(UIColor.red, for: .normal)
            self.buttonViews.setTitleColor(UIColor.darkGray, for: .normal)
            self.buttonOrderCount.setTitleColor(UIColor.darkGray, for: .normal)
            break
        case .MostViewedProducts:
            
            self.buttonViews.setTitleColor(UIColor.red, for: .normal)
            self.buttonShares.setTitleColor(UIColor.darkGray, for: .normal)
            self.buttonOrderCount.setTitleColor(UIColor.darkGray, for: .normal)
            break
        case .MostOrdeRedProducts:
            
            self.buttonOrderCount.setTitleColor(UIColor.red, for: .normal)
            self.buttonViews.setTitleColor(UIColor.darkGray, for: .normal)
            self.buttonShares.setTitleColor(UIColor.darkGray, for: .normal)
            break
        default:
            break
        }
    }
    
    @IBAction func actionSortByViews(_ sender: Any) {
        
        self.sortData(sortType: .MostViewedProducts)
    }
    @IBAction func actionSortByCount(_ sender: Any) {
        
        self.sortData(sortType: .MostOrdeRedProducts)
    }
    @IBAction func actionSortByShares(_ sender: Any) {
        
        self.sortData(sortType: .MostShaRedProducts)
    }
    
    func makeDataSource() {
        
        for product in (self.category?.products)! {
            
            for varient in product.variants {
                
                let productDataSource = ProductDataSource(varient: varient, product: product)
                self.arrayDataSource.append(productDataSource)
            }
        }
    }

    func sortData(sortType: RankingType) -> Void {
        
        switch sortType {
        case .MostShaRedProducts:
            
            arrayDataSource = self.arrayDataSource.sorted { (prevData, laterData) -> Bool in
                
                prevData.shares! > laterData.shares!
            }
            break
        case .MostViewedProducts:
            
            arrayDataSource = self.arrayDataSource.sorted { (prevData, laterData) -> Bool in
                
                prevData.view_count! > laterData.view_count!
            }
            break
        case .MostOrdeRedProducts:
            
            arrayDataSource = self.arrayDataSource.sorted { (prevData, laterData) -> Bool in
                
                prevData.order_count! > laterData.order_count!
            }
            break
        default:
            break
        }
        
        self.collectionView.reloadData()
        self.updateSortUI(sortType: sortType)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCellId, for: indexPath) as!  ProductCollectionViewCell
        
        let productDatasource = arrayDataSource[indexPath.row]
        cell.labelProductName.text = productDatasource.product?.name
        cell.labelProductPrice.text = "₹ \(productDatasource.price!)"
        cell.labelSize.text = productDatasource.size! > 0 ? "\(productDatasource.size!)": ""
        cell.labelColor.text = productDatasource.color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width/2 - 2, height: self.view.frame.size.width/2)
    }
}
