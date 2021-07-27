//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Ashok on 23/07/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    private var downloadTask: URLSessionDownloadTask?
    
    func configreCell(cell:ImageCollectionViewCell,photo:Photo){
        if photo.farm != 0 {
            if let url = URL.init(string: "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg") {
                downloaImage(imageURL: url, imageView: cell.customImageView)
            }
        }
    }
  
    
    // MARK: - URLSessionDownloadTask
    
    public func downloaImage(imageURL: URL?,imageView:UIImageView) {
        
        if let urlOfImage = imageURL {
            if let cachedImage = imageCache.object(forKey: urlOfImage.absoluteString as NSString){
                    imageView.image = cachedImage as? UIImage
            } else {
                activtyIndicator.startAnimating()
                imageView.isHidden = true
                let session = URLSession.shared
                self.downloadTask = session.downloadTask(
                    with: urlOfImage as URL, completionHandler: { [weak self] url, response, error in
                        if error == nil, let url = url, let data = NSData(contentsOf: url), let image = UIImage(data: data as Data) {
                            DispatchQueue.main.async() {
                                let imageToCache = image
                                if let strongSelf = self, let imageView = strongSelf.customImageView {
                                    self?.activtyIndicator.stopAnimating()
                                    imageView.isHidden = false
                                        imageView.image = imageToCache
                                    self?.imageCache.setObject(imageToCache, forKey: urlOfImage.absoluteString as NSString)
                                }
                            }
                        }
                    })
                self.downloadTask!.resume()
               
                
            }
        }
    }
}
