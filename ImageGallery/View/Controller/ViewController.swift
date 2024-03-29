//
//  ViewController.swift
//  ImageGallery
//
//  Created by Ashok on 23/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageSearchBar: UISearchBar?
    @IBOutlet weak var imageCollectionView: UICollectionView?
    let dataSource = ImageDataSource()
    lazy var viewModel : ImageDataViewModel = {
        let viewModel = ImageDataViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageSearchBar?.text = "kittens"
        self.imageCollectionView?.dataSource = self.dataSource
        self.imageCollectionView?.delegate = self.dataSource
        self.imageSearchBar?.delegate = self
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.imageCollectionView?.reloadSections(IndexSet.init(integer: 0))
        }
        
        viewModel.getImageData(searchText: Utils.searchText, page: Utils.page)
        
    }
}
extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text,!searchText.isEmpty else { return }
        Utils.page = 1
        self.imageCollectionView?.setContentOffset(.zero, animated: false)
        viewModel.getImageData(searchText:searchText, page: 1)
        
    }
}
