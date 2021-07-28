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
    
    func getImageData(searchText:String,page:Int,isDataRefresh:Bool) {
        Utils.searchText = searchText
        UIApplication.shared.windows[0].rootViewController?.view.endEditing(true)
        let urlString = Utils().getFlickerAPIUrl(searchText: searchText, page: page)
        APIService.sharedInstance.getImagesWithUrl(urlString: urlString) { imageDataModel, error in
            if imageDataModel?.stat == "ok",imageDataModel?.photos?.photo.count ?? 0 > 0{
                if isDataRefresh {
                    self.dataSource?.data.value = imageDataModel?.photos?.photo ?? []
                }else{
                    self.dataSource?.data.value.append(contentsOf: imageDataModel?.photos?.photo ?? [])
                }
            }else{
                CustomAlert().showAlertWithMessage(message: NSLocalizedString("label.alert.ImageData.noDataMessage", comment: ""), title: "")
            }
        }
    }
}
