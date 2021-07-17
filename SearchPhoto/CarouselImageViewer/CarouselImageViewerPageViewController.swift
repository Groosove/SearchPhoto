//
//  CarouselImageViewerPageViewController.swift
//  Jisp
//
//  Created by Anton Cheremukhin on 15/11/2018.
//  Copyright © 2018 Bubbles. All rights reserved.
//

import UIKit

protocol CarouselImageViewerPageDelegate: AnyObject {
	func viewDidTapped()
	func viewZoomChanged(isZoomed: Bool)
}

class CarouselImageViewerPageViewController: UIViewController {

	private var scrollView = UIScrollView()
	private var imageView = UIImageView()

	private var image: UIImage?

	weak var delegate: CarouselImageViewerPageDelegate?

	public var viewIsZoomed: Bool {
		return scrollView.zoomScale != 1
	}

	init(image: UIImage, delegate: CarouselImageViewerPageDelegate?) {
		super.init(nibName: nil, bundle: nil)
		self.image = image
		self.delegate = delegate
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		scrollView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		configureSubviews()
		configureConstraints()

		if let image = image {
			showImage(image: image)
		}
	}

	private func showImage(image: UIImage) {
		imageView.image = image
	}

	@objc private func tapAction(_ sender: Any) {
		delegate?.viewDidTapped()
	}

	func configureSubviews() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.maximumZoomScale = 5
		view.addSubview(scrollView)

		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		scrollView.addSubview(imageView)

		scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction(_:))))
	}

	func configureConstraints() {
		// Scroll View
		scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

		// Image View
		imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
		imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true

	}
}

extension CarouselImageViewerPageViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}

	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		let boundsSize = scrollView.bounds.size
		var frameToCenter = imageView.frame

		if (frameToCenter.size.width < boundsSize.width) {
			frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
		}
		else {
			frameToCenter.origin.x = 0
		}

		if (frameToCenter.size.height < boundsSize.height) {
			frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
		}
		else {
			frameToCenter.origin.y = 0
		}

		imageView.frame = frameToCenter

		delegate?.viewZoomChanged(isZoomed: scrollView.zoomScale != 1)
	}
}
