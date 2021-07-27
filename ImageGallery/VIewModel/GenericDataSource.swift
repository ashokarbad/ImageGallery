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


