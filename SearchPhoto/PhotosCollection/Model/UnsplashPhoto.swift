//
//  Created by Artur Lutfullin on 03/07/2021.
//

enum URLKing: String {
	case raw
	case full
	case regular
	case small
	case thumb
}

struct PhotosCollectionModel: Decodable {
	let total: Int
	let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
	let width: Int
	let height: Int
	// swiftlint:disable colon
	let urls: [URLKing.RawValue : String]
	// swiftlint:enable colon
}
