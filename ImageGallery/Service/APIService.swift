//
//  APIService.swift
//  ImageGallery
//
//  Created by Ashok on 23/07/21.
//

import UIKit

class APIService: NSObject {

    static let sharedInstance = APIService()
    
    func getImagesWithUrl(urlString:String, completion: @escaping (ImageDataModel?,Error?) -> ()){
        
        guard let url = URL(string:urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if(error != nil){
                print("error ", error as Any)
            }else{
                guard let inputData = data else { return }
                do {
                    let results = try JSONDecoder().decode(ImageDataModel.self, from: inputData)
                    DispatchQueue.main.async {
                        completion(results,nil)
                    }
                } catch let error {
                    print("error " + error.localizedDescription)
                }
            }
        }.resume()
    }
    
}
