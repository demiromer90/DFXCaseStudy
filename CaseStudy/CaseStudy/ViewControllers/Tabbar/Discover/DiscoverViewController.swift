//
//  DiscoverViewController.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var collectionView:UICollectionView!
    private var refreshControl = UIRefreshControl()
    
    private let spinner = CommonIndicator()
    let viewModel = DiscoverViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setUI()
        
        viewModel.getLists()
    }
    
    private func setUI(){
        collectionView.register(UINib.init(nibName: String(describing: HorizontalListCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: HorizontalListCollectionViewCell.defaultReuseIdentifier)
        collectionView.register(UINib.init(nibName: String(describing: ProductCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.defaultReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        viewModel.getLists(withSpinner: false)
    }
    
}



//MARK: - DiscoverViewModelDelegate
extension DiscoverViewController: DiscoverViewModelDelegate {
    func serviceError(error: Error) {
        showError(error: error)
    }
    
    func triggerSpinner(isShow: Bool) {
        if isShow {
            spinner.startAnimatingOnView(view: view)
        }else{
            spinner.stopAnimating()
        }
    }
    
    func getCollectionViewWidth() -> CGFloat {
        return collectionView.frame.size.width
    }
    
    func listLoaded() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
}
