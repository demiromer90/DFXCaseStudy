//
//  DiscoverViewController+Collection.swift
//  CaseStudy
//
//  Created by Ömer Demir on 27.11.2022.
//

import UIKit


extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.collectionItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.viewModel.collectionItemList[indexPath.row]
        
        if let horizontalListCellVM = item.data as? HorizontalListCellVM {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalListCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! HorizontalListCollectionViewCell
            cell.configureCellWith(listVM: horizontalListCellVM)
            return cell
            
        }else if let productCellVM = item.data as? ProductCellVM{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! ProductCollectionViewCell
            cell.configureWith(productVM: productCellVM)
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    
    
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.viewModel.collectionItemList[indexPath.row]
        return item.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: self.viewModel.sectionInset, bottom: 16, right:self.viewModel.sectionInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.itemSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.lineSpace
    }
    
}

