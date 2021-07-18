//
//  PhotoViewerModel.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.21.
//

import UIKit
import CoreLocation

struct PhotoViewerModel {
    let uid: String
    let name: String
    let image: UIImageView
    let width: CGFloat
    let height: CGFloat
    let imageURL: String
}

struct PhotoStatModel: Decodable {
    let created_at: String
    let id: String
    let downloads: Int
    let likes: Int
    let description: String?
    let exif: Exif?
    let location: Location?
    
}

struct Exif: Decodable {
    let make: String?
    let model: String?
    let exposure_time: String?
    let aperture: String?
    let focal_length: String?
    let iso: Int?
}

struct Location: Decodable {
    let title: String?
    let name: String?
    let city: String?
    let country: String?
	var coordinate: CLLocationCoordinate2D? {
		guard let lat = position?.latitude, let long = position?.longitude else { return nil }
		return CLLocationCoordinate2D(latitude: lat, longitude: long)
	}
    private let position: Coordinate?
}

struct Coordinate: Decodable {
    let latitude: Double?
    let longitude: Double?
}
