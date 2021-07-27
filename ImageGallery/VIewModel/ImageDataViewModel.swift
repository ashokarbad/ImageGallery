//
//  ImageDataViewModel.swift
//  ImageGallery
//
//  Created by Ashok on 24/07/21.
//

import UIKit

class ImageDataViewModel: NSObject {
    
    weak var dataSource : GenericDataSource<Photo>?
    
    init(dataSource : GenericDataSource<Photo>?) {
        self.dataSource = dataSource
    }
    
    func getImageData(searchText:String,page:Int) {
        var imageData = [Photo]()
        UIApplication.shared.windows[0].rootViewController?.view.endEditing(true)
        let urlString = Utils().getFlickerAPIUrl(searchText: searchText, page: page)
        APIService.sharedInstance.getImagesWithUrl(urlString: urlString) { imageDataModel, error in
            if imageDataModel?.stat == "ok",imageDataModel?.photos?.photo.count ?? 0 > 0{
                if let photo = imageDataModel?.photos?.photo{
                    imageData.append(contentsOf: photo)
                    self.dataSource?.data.value = imageData
                }
            }else{
                CustomAlert().showAlertWithMessage(message: NSLocalizedString("label.alert.ImageData.noDataMessage", comment: ""), title: "")
            }
        }
    }
}
