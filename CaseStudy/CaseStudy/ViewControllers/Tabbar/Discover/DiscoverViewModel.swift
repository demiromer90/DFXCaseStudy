//
//  DiscoverViewModel.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import UIKit

protocol DiscoverViewModelDelegate: ServiceViewModelProtocol {
    func listLoaded()
    func getCollectionViewWidth() -> CGFloat
}


class DiscoverViewModel: ServiceViewModel {
    
    weak var delegate:DiscoverViewModelDelegate?
    
    
    //MARK: - Api Req
    private var firstHorizontalList:[Product] = []
    private var secondHorizontalList:[Product] = []
    private var thirdList:[Product] = []
    
    func getLists(withSpinner:Bool = true) {
        if withSpinner {
            delegate?.triggerSpinner(isShow: true)
        }
        
        
        firstHorizontalList = []
        secondHorizontalList = []
        thirdList = []
        
        let group = DispatchGroup()
        
        group.enter()
        requestManager.getFirstList { [weak self] result in
            if case .success(let response) = result, let list = response.list {
                self?.firstHorizontalList = list
            }
            
            group.leave()
        }
        
        group.enter()
        requestManager.getSecondList { [weak self] result in
            if case .success(let response) = result, let list = response.list {
                self?.secondHorizontalList = list
            }
            
            group.leave()
        }
        
        group.enter()
        requestManager.getThirdList { [weak self] result in
            if case .success(let response) = result, let list = response.list {
                self?.thirdList = list
            }
            
            group.leave()
        }
        
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            if withSpinner {
                self?.delegate?.triggerSpinner(isShow: false)
            }
            
            self?.fillCollectionItemList()
            self?.delegate?.listLoaded()
        }
    }
    
    
    //MARK: - Collection Models
    let sectionInset:CGFloat = 8.0
    let itemSpace:CGFloat = 4.0
    var lineSpace:CGFloat = 16.0
    
    enum ListType {
        case first, second, third
        
        var imageRatio:CGFloat {
            switch self {
            case .first:
                return 1.3
            case .second:
                return 0.7
            case .third:
                return 1.0
            }
        }
        
        var descriptionFontSize:CGFloat {
            switch self {
            case .first:
                return 16.0
            case .second:
                return 12.0
            case .third:
                return 14.0
            }
        }
        
        var totalItemInOneRow:Int {
            switch self {
            case .first:
                return 2
            case .second:
                return 3
            case .third:
                return 2
            }
        }
        
        var isHorizontalList:Bool {
            switch self {
            case .first, .second:
                return true
            case .third:
                return false
            }
        }
        
    }
    
    var collectionItemList:[DiscoverCollectionItem] = []
    
    private func fillCollectionItemList(){
        collectionItemList = []
        
        //First horizontal
        if firstHorizontalList.count > 0 {
            let listType:ListType = .first
            let list:[ProductCellVM] = firstHorizontalList.map { product in
                return ProductCellVM(product: product, imageRatio: listType.imageRatio, descriptionFontSize: listType.descriptionFontSize)
            }
            let sizeTuple = getItemSizesWithListType(listType: listType)
            let horizontalListVM = HorizontalListCellVM(list: list, itemSpace: itemSpace, itemSize: sizeTuple.itemSize)
            collectionItemList.append(DiscoverCollectionItem(data: horizontalListVM, size: sizeTuple.collectionSize))
            
        }
        
        //Second horizontal
        if secondHorizontalList.count > 0 {
            let listType:ListType = .second
            let list:[ProductCellVM] = secondHorizontalList.map { product in
                return ProductCellVM(product: product, imageRatio: listType.imageRatio, descriptionFontSize: listType.descriptionFontSize)
            }
            let sizeTuple = getItemSizesWithListType(listType: listType)
            let horizontalListVM = HorizontalListCellVM(list: list, itemSpace: itemSpace, itemSize: sizeTuple.itemSize)
            collectionItemList.append(DiscoverCollectionItem(data: horizontalListVM, size: sizeTuple.collectionSize))
        }
        
        //Third
        if thirdList.count > 0 {
            let listType:ListType = .third
            for product in thirdList {
                let productVM = ProductCellVM(product: product, imageRatio: listType.imageRatio, descriptionFontSize: listType.descriptionFontSize)
                let sizeTuple = getItemSizesWithListType(listType: listType)
                collectionItemList.append(DiscoverCollectionItem(data: productVM, size: sizeTuple.collectionSize))
            }
        }
    }
    
    private func getItemSizesWithListType(listType:ListType) -> (collectionSize:CGSize, itemSize:CGSize) {
        if let collectionViewWidth = self.delegate?.getCollectionViewWidth() {
            let totalItemInOneRow:CGFloat = CGFloat(listType.totalItemInOneRow)
            let totalSpace = itemSpace * (totalItemInOneRow - 1)
            let totalInsets:CGFloat = 2 * sectionInset
            let productItemwidth:CGFloat = floor((collectionViewWidth - totalInsets - totalSpace) / totalItemInOneRow)
            
            let descriptionLinesHeight = UIFont.systemFont(ofSize: listType.descriptionFontSize).lineHeight * 3.0
            let height:CGFloat = floor((productItemwidth / listType.imageRatio) + 90 + descriptionLinesHeight)
            
            let itemSize = CGSize(width: productItemwidth, height: height)
            let collectionSize:CGSize!
            
            if listType.isHorizontalList {
                collectionSize = CGSize(width: collectionViewWidth - totalInsets, height: height)
            }else{
                collectionSize = CGSize(width: productItemwidth, height: height)
            }
            
            return (collectionSize, itemSize)
        }
        
        return (.zero, .zero)
    }
    
    
}
