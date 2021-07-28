//
//  ImageDataSource.swift
//  ImageGallery
//
//  Created by Ashok on 27/07/21.
//

import UIKit

class ImageDataSource: GenericDataSource<Photo>, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    let columnCount : CGFloat = 3
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.ImageCollectionViewCell, for: indexPath) as? ImageCollectionViewCell{
            cell.transform = collectionView.transform
            if let photo = data.value[indexPath.row] as Photo?{
                cell.configreCell(cell: cell, photo: photo)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == data.value.count - 1 {
            Utils.page += 1
            let updateData = UpdateData(dataSource: self, searchText: Utils.searchText, page: Utils.page)
            updateData.refresh()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let collectionViewWidth = collectionView.bounds.width
        let extraSpace = (columnCount - 1) * flowLayout.minimumInteritemSpacing
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        let width = Int((collectionViewWidth - extraSpace - inset) / columnCount)
        return CGSize.init(width: width, height: width)
    }
}
