//
//  ViewController.swift
//  ImageGallery
//
//  Created by Ashok on 23/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageSearchBar: UISearchBar?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var imageCollectionView: UICollectionView?
    private var photosArray = [ImageDataViewModel]()
    let columnCount : CGFloat = 3
    var page = 1
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSearchBar?.text = "kittens"
        getImagesFromServer(searchText: "kittens")
    }
    
    // MARK: - Private
    
    private func getImagesFromServer(searchText:String) {
        self.activityIndicator?.startAnimating()
        let urlString = Utils().getFlickerAPIUrl(searchText: searchText, page: page)
        APIService.sharedInstance.getImagesWithUrl(urlString: urlString) { imageDataModel, error in
            self.activityIndicator?.stopAnimating()
            if imageDataModel?.stat == "ok",imageDataModel?.photos?.photo.count ?? 0 > 0{
                self.photosArray.append(contentsOf: imageDataModel?.photos?.photo.map({ImageDataViewModel(photo: Photo(id: $0.id, owner: $0.owner, secret: $0.secret, server: $0.server, farm: $0.farm, title: $0.title))}) ?? [])
                self.imageCollectionView?.reloadData()
            }else{
                CustomAlert().showAlertWithMessage(message: NSLocalizedString("label.alert.ImageData.noDataMessage", comment: ""), title: "")
            }
        }
    }
}

// MARK: - CollectionView

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let collectionViewWidth = collectionView.bounds.width
        let extraSpace = (columnCount - 1) * flowLayout.minimumInteritemSpacing
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        let width = Int((collectionViewWidth - extraSpace - inset) / columnCount)
        return CGSize.init(width: width, height: width)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.ImageCollectionViewCell, for: indexPath) as! ImageCollectionViewCell
        if let imageData = photosArray[indexPath.row] as ImageDataViewModel?{
            cell.configreCell(cell: cell, imageData: imageData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == photosArray.count - 1 ) {
            guard let searchText = imageSearchBar?.searchTextField.text,!searchText.isEmpty else { return }
            page += 1; getImagesFromServer(searchText: searchText)
        }
    }
}

// MARK: - SearchBar

extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        guard let searchText = searchBar.searchTextField.text,!searchText.isEmpty else { return }
        photosArray = [ImageDataViewModel]()
        imageCollectionView?.reloadData()
        page = 1; getImagesFromServer(searchText: searchText)
    }
}


