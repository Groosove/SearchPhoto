//
//  UIImage_Extenshions.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/28/21.
//

import UIKit

extension UIImage {
	func cropImage(targetSize: CGSize) -> UIImage? {
		guard let cgImage = self.cgImage else { return nil }
		let contextImage: UIImage = UIImage(cgImage: cgImage)
		let contextSize: CGSize = contextImage.size
		var rect = CGRect.zero

		if contextSize.width > contextSize.height {
			rect = CGRect(x: ((contextSize.width - contextSize.height) / 2), y: 0, width: contextSize.height, height: contextSize.height)
		} else {
			rect = CGRect(x: 0, y: ((contextSize.height - contextSize.width) / 2), width: contextSize.width, height: contextSize.width)
		}

		guard let imageRef = cgImage.cropping(to: rect) else { return nil }
		let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

		return image
	}
	
	func resizeImage(targetSize: CGSize) -> UIImage? {
		let size = self.size
		let widthRatio  = targetSize.width  / size.width
		let heightRatio = targetSize.height / size.height
		var newSize: CGSize

		if widthRatio > heightRatio {
			newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
		} else {
			newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
		}
		let rect = CGRect(origin: .zero, size: newSize)
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		self.draw(in: rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
}
