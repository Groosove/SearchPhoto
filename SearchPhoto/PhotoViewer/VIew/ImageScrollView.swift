//
//  ImageScrollView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 25.07.2021.
//

import UIKit

final class ImageScrollView: UIScrollView {
	private let image: UIImage
	weak var delegateController: PhotoViewerControllerDelegate?
	lazy var imageView: UIImageView = {
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.sizeToFit()
		return imageView
	}()
	override var frame: CGRect {
		didSet {
			if frame.size != oldValue.size { setZoomScale() }
		}
	}

	init(image: UIImage) {
		self.image = image
		super.init(frame: .zero)
		addSubview(imageView)
		contentSize = imageView.bounds.size

		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		delegate = self
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Zoom Scale
	func setZoomScale() {
		let widthScale = frame.size.width / imageView.bounds.width
		let heightScale = frame.size.height / imageView.bounds.height
		let minScale = min(widthScale, heightScale)
		minimumZoomScale = minScale
		zoomScale = minScale
	}
}

extension ImageScrollView: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}

	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		let imageViewSize = imageView.frame.size
		let scrollViewSize = scrollView.bounds.size
		let verticalInset = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
		let horizontalInset = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
		scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
	}
}
