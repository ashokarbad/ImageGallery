//
//  ImageDataModel.swift
//  ImageGallery
//
//  Created by Ashok on 24/07/21.
//

import UIKit

class ImageDataModel : Decodable {
    var photos: Photos?
    var stat: String
    var code: Int?
    var message: String?
    
    init(photos: Photos, stat: String) {
        self.photos = photos
        self.stat = stat
    }
    
    init(stat: String, code: Int, message: String) {
        self.stat = stat
        self.code = code
        self.message = message
    }
}

// MARK: - Photos
class Photos : Decodable {
    let page, pages, perpage, total: Int
    let photo: [Photo]

    init(page: Int, pages: Int, perpage: Int, total: Int, photo: [Photo]) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        self.photo = photo
    }
}

// MARK: - Photo
class Photo : Decodable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    var ispublic, isfriend, isfamily: Int?

    init(id: String, owner: String, secret: String, server: String, farm: Int, title: String, ispublic: Int, isfriend: Int, isfamily: Int) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }
    
    init(id: String, owner: String, secret: String, server: String, farm: Int, title: String) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
    }
}
