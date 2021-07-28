//
//  GenericDataSource.swift
//  ImageGallery
//
//  Created by Ashok on 27/07/21.
//

import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}


class UpdateData {
    var dataSource = ImageDataSource()
    var page = 1
    var searchText = ""
    
    lazy var viewModel : ImageDataViewModel = {
        let viewModel = ImageDataViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    init(dataSource:ImageDataSource,searchText:String,page:Int) {
        self.dataSource = dataSource
        self.page = page
        self.searchText = searchText
    }
    func refresh() {
        viewModel.getImageData(searchText: searchText, page: page, isDataRefresh: false)
    }
}

