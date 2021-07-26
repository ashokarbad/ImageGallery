//
//  ImageDataViewModel.swift
//  ImageGallery
//
//  Created by Ashok on 24/07/21.
//

import UIKit

class ImageDataViewModel: NSObject {
    let id, owner, secret, server: String
    let farm: Int
    let title: String

    init(photo:Photo) {
        self.id = photo.id
        self.owner = photo.owner
        self.secret = photo.secret
        self.server = photo.server
        self.farm = photo.farm
        self.title = photo.title
    }
    
    func getImageUrl() -> String {
        return "http://farm\(self.farm).static.flickr.com/\(self.server)/\(self.id)_\(self.secret).jpg"
    }
}
