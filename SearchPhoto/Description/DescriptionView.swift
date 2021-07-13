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
	
	lazy var mapViewLandmark: MKMapView? = {
		guard let location = model.location else { return nil }
		let annotation = MKPointAnnotation()
		let map = MKMapView(frame: CGRect(origin: .zero,
										  size: CGSize(width: self.frame.width, height: self.frame.height / 3)))
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
	
	lazy var descriptionLabel: UILabel? = {
		guard let description = model.description else { return nil }
		let label = dataMetaData(with: description)
		return label
	}()
	
	
	init(model: PhotoStatModel) {
		self.model = model
		super.init(frame: UIScreen.main.bounds)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func titleMetaData(with text: String) -> UILabel {
		let label = UILabel()
		label.textColor = .systemGray
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = text
		return label
	}
	
	private func dataMetaData(with text: String) -> UILabel {
		let label = UILabel()
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = text
		return label
	}
}
