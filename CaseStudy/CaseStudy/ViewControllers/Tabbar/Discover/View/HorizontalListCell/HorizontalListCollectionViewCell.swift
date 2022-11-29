//
//  HorizontalListCollectionViewCell.swift
//  CaseStudy
//
//  Created by Ömer Demir on 28.11.2022.
//

import UIKit

class HorizontalListCollectionViewCell: UICollectionViewCell {
    static let defaultReuseIdentifier = "HorizontalListCell"
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    private var listVM:HorizontalListCellVM!
  
    
    func configureCellWith(listVM:HorizontalListCellVM) {
        self.listVM = listVM
        
        collectionView.register(UINib.init(nibName: String(describing: ProductCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.defaultReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
}



extension HorizontalListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listVM.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productVM = self.listVM.list[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.defaultReuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.configureWith(productVM: productVM)
        
        return cell
    }
    
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.listVM.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.listVM.itemSpace
    }
    
}
