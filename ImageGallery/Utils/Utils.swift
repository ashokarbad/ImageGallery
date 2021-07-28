//
//  Utils.swift
//  ImageGallery
//
//  Created by Ashok on 24/07/21.
//

import UIKit

class Utils: NSObject {
    static var searchText = "kittens"
    static var page = 1
    func getUserDefinedParameter(keyName:String) -> String {
        if let parameter =  Bundle.main.object(forInfoDictionaryKey: keyName) as? String{
            return parameter
        }
        return ""
    }
    
    func getFlickerAPIUrl(searchText:String,page:Int) -> String {
        return getUserDefinedParameter(keyName: Constant.imageUrlKey) + "\(searchText)" + "&page=\(page)";
    }
}

class CustomAlert {
    func showAlertWithMessage(message:String,title:String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("label.alert.ImageData.buttonTitle", comment: ""), style: .default, handler: doSomething))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func doSomething(action: UIAlertAction) {
        print("Continue button clicked")
    }
}
struct Constant {
    static let imageUrlKey = "imageUrl"
    static let ImageCollectionViewCell = "ImageCollectionViewCell"
}
