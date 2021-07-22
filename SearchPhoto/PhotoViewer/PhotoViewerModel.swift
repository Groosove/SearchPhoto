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
    let createAt: String
    let uid: String
    let downloads: Int
    let likes: Int
    let description: String?
    let exif: Exif?
    let location: Location?

	enum CodingKeys: String, CodingKey {
		case uid = "id"
		case downloads
		case likes
		case description
		case location
		case exif
		case createAt = "created_at"
	}
}

struct Exif: Decodable {
    let make: String?
    let model: String?
    let exposureTime: String?
    let aperture: String?
    let focalLength: String?
    let iso: Int?

	enum CodingKeys: String, CodingKey {
		case make
		case model
		case exposureTime = "exposure_time"
		case aperture
		case focalLength = "focal_length"
		case iso
	}
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
