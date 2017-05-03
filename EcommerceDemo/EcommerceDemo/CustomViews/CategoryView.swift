//
//  CategoryView.swift
//  EcommerceDemo
//
//  Created by Faasos on 03/05/17.
//  Copyright © 2017 Pooja. All rights reserved.
//

import UIKit

class CategoryView: UIView, UITableViewDelegate, UITableViewDataSource, HeaderDelegate {
    
    lazy var tableViewCategory: UITableView = {
        
        var tableView:UITableView = UITableView(frame:CGRect(x: 0, y: 20, width: self.frame.size.width, height: self.frame.size.height))
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "CategoryTableViewCell", bundle:nil)
        
        tableView.register(nibName, forCellReuseIdentifier: CategoryTableViewCellId)
        
        let productNibName = UINib(nibName: "ProductCategoryTableViewCell", bundle:nil)
        
        tableView.register(productNibName, forCellReuseIdentifier: ProductCategoryTableViewCellId)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    var arrayCategories : [Category] = []
    var arrayDataSource : [CategoryDatasource] = []
    var selectedRootCategoryIndex : Int?
    var lastOpenRowDataSource : CategoryDatasource?
    var selectedRowCategory : Int?
    var previousOpenIndexes : [IndexPath] = []
    
    
    init(frame: CGRect, categories: [Category]) {
        
        super.init(frame: frame)
        self.addSubview(self.tableViewCategory)
        self.arrayCategories = categories
        makeDataSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeDataSource() -> Void {
        
        for category in self.arrayCategories {
            
            if !category.categories.isEmpty {
                
                let categoryDataSource = CategoryDatasource.init(category: category , categoryCelltype: CategoryCelltype.WithChildCategory)
                self.arrayDataSource.append(categoryDataSource)
            } else {
                
                let categoryDataSource = CategoryDatasource.init(category: category , categoryCelltype: CategoryCelltype.WithProducts)
                self.arrayDataSource.append(categoryDataSource)
            }
        }
        
        self.tableViewCategory.reloadData()

    }
    
    //MARK: - TableView methods
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryDatasource = self.arrayDataSource[indexPath.section]
        
        
        let childCategory = categoryDatasource.nestedCategoryDatasource[indexPath.row].category
        if !(childCategory?.categories.isEmpty)! {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCellId, for: indexPath as IndexPath) as! CategoryTableViewCell
            
            cell.labelTitle.text = childCategory?.name
            return cell

            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategoryTableViewCellId, for: indexPath as IndexPath) as! ProductCategoryTableViewCell
            
//            let childCategory = childCategory?.categories[indexPath.row]
            
            
            cell.labelTitle.text = childCategory?.name
            return cell
            
            
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == self.selectedRootCategoryIndex{
            
            return self.arrayDataSource[section].nestedCategoryDatasource.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let headerView = HeaderView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 60))
        headerView.index = section
        headerView.delegate = self
        
        let labelTitle = UILabel(frame: CGRect(x: 20, y: 0, width: self.frame.size.width, height: 60))
        let category = self.arrayDataSource[section].category
        labelTitle.text = category?.name
        labelTitle.sizeToFit()
        
        headerView.addSubview(labelTitle)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedRowCategory != nil {
            
            let index = IndexPath(row: selectedRowCategory!, section: indexPath.section)
            if index != indexPath {
                let categoryDatasource = self.arrayDataSource[indexPath.section]
                let childCategory = categoryDatasource.nestedCategoryDatasource[indexPath.row].category
                if !(childCategory?.categories.isEmpty)! {
                    
                    selectedRowCategory = indexPath.row
                    self.expandCellsAt(indexPath: indexPath)
                    
                } else {
                    
                    
                }
            }
        } else {
            
            selectedRowCategory = indexPath.row
            self.expandCellsAt(indexPath: indexPath)
        }
        
        
    }
    
    func expandCellsAt(indexPath: IndexPath) -> Void {
        
        let categoryDatasource = self.arrayDataSource[indexPath.section]
        
        let childCategory = categoryDatasource.nestedCategoryDatasource[selectedRowCategory!].category
        
        if !(childCategory?.categories.isEmpty)! {
            
            var arrayRowDataSource : [CategoryDatasource] = []
            var arrayIndexPath : [IndexPath] = []
            
            
            for nestedChildCategory in (childCategory?.categories)! {
                
                let childcategoryDatasource = CategoryDatasource(category: nestedChildCategory, categoryCelltype: CategoryCelltype.WithChildCategory)
                arrayRowDataSource.append(childcategoryDatasource)
                
                let indexPath = IndexPath(row: selectedRowCategory! + arrayRowDataSource.count, section: indexPath.section)
                
                arrayIndexPath.append(indexPath)
                categoryDatasource.nestedCategoryDatasource.insert(childcategoryDatasource, at: selectedRowCategory! + arrayRowDataSource.count)
            }
            
            self.tableViewCategory.insertRows(at: arrayIndexPath, with: UITableViewRowAnimation.none)
            previousOpenIndexes = arrayIndexPath
        } else {
            
            
        }
    }
    
    func collapsePreviousCells(indexPath: IndexPath) -> Void {
        
        if previousOpenIndexes.first?.section == indexPath.section {
            
            let categoryDatasource = self.arrayDataSource[indexPath.section]
            
            for (index, _) in categoryDatasource.nestedCategoryDatasource.enumerated() {
                
                let arrayIndex = previousOpenIndexes.filter() {
                    
                    $0.row == index
                }
                if !arrayIndex.isEmpty {
                    
                    categoryDatasource.nestedCategoryDatasource.remove(at: index)
                }
            }
            
            self.tableViewCategory.deleteRows(at: previousOpenIndexes, with: UITableViewRowAnimation.none)
            
        }
    }
    
    func didTapSectionAtIndex(index: Int) {
        
        self.selectedRootCategoryIndex = index
        
        let lastOpenParentDataSource = arrayDataSource[index]
        
        var arrayRowDatasource : [CategoryDatasource] = []
        
        for category in (lastOpenParentDataSource.category?.categories)! {
            
            let categoryDataSource = CategoryDatasource(category: category, categoryCelltype: CategoryCelltype.WithChildCategory)
            
            arrayRowDatasource.append(categoryDataSource)
        }
        
        lastOpenParentDataSource.nestedCategoryDatasource = arrayRowDatasource
        self.tableViewCategory.reloadData()
        
    }
    
}
