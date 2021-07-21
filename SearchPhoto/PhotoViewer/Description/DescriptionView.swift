//
//  DescriptionView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 14.07.2021.
//

import UIKit
import MapKit

class DescriptionView: UIView {
	let model: PhotoStatModel
	weak var delegate: DescriptionViewControllerDelegate?
	
	lazy var dismissButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "down"), for: .normal)
		button.tintColor = .white
		button.addTarget(delegate, action: #selector(dismissController), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	lazy var mapViewLocation: MKMapView = {
		guard let location = model.location, model.location?.coordinate != nil else {
            let map = MKMapView(frame: CGRect(origin: .zero, size: CGSize(width: frame.width, height: 10)))
            map.isHidden = true
            map.translatesAutoresizingMaskIntoConstraints = false
            return map
        }
        
		let annotation = MKPointAnnotation()
		let map = MKMapView()
		map.frame.size = CGSize(width: self.frame.width, height: self.frame.height / 5)
		annotation.title = location.name
		annotation.coordinate = location.coordinate!
		map.setRegion(MKCoordinateRegion(center: annotation.coordinate,
										 latitudinalMeters: 50000,
										 longitudinalMeters: 60000), animated: true)
		map.centerCoordinate = annotation.coordinate
		map.mapType = .standard
		map.addAnnotation(annotation)
		map.isScrollEnabled = true
		map.translatesAutoresizingMaskIntoConstraints = false
		return map
	}()
	
	lazy var exifView = EXIFView(model: model.exif)
	
	lazy var descriptionLabel: UILabel = {
        guard let description = model.description else {
            let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: frame.width, height: 10)))
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
		let label = UILabel()
		label.textColor = .white
		label.numberOfLines = 0
        label.text = description
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let scrollView = UIScrollView()
	
	init(model: PhotoStatModel) {
		self.model = model
		super.init(frame: UIScreen.main.bounds)

		addSubviews()
		makeConstraints()
	}
	
	private func addSubviews() {
		addSubview(dismissButton)
		addSubview(scrollView)
		scrollView.addSubview(exifView)
		scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(mapViewLocation)
	}
	
	private func makeConstraints() {
		exifView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		let dismissButtonConstraints = [
			dismissButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			dismissButton.topAnchor.constraint(equalTo: self.topAnchor),
			dismissButton.widthAnchor.constraint(equalToConstant: 100),
			dismissButton.heightAnchor.constraint(equalToConstant: 40),
		]

		let scrollViewConstraints = [
			scrollView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor),
		]
		
		let exifViewConstraints = [
			exifView.topAnchor.constraint(equalTo: mapViewLocation.bottomAnchor, constant: 10),
			exifView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor),
			exifView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
		]

		let descriptionLabelConstraints = [
			descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.frame.height),
		]

		let mapViewConstraints = [
            mapViewLocation.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant:  10),
            mapViewLocation.heightAnchor.constraint(equalToConstant: mapViewLocation.frame.height),
            mapViewLocation.widthAnchor.constraint(equalToConstant: mapViewLocation.frame.width),
		]
		
		NSLayoutConstraint.activate(scrollViewConstraints)
		NSLayoutConstraint.activate(dismissButtonConstraints)
		NSLayoutConstraint.activate(exifViewConstraints)
		NSLayoutConstraint.activate(descriptionLabelConstraints)
		NSLayoutConstraint.activate(mapViewConstraints)
	}
	
	@objc private func dismissController() {
		delegate?.dismissSelf()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
