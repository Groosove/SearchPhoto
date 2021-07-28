//
//  ImageView_Extension.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 11.07.21.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImage(imageURL: String) {
        if let image = imageCache.object(forKey: imageURL as NSString) as? UIImage {
            self.image = image
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: imageURL), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            imageCache.setObject(image, forKey: imageURL as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
