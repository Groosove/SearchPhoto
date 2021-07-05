//
//  Created by Artur Lutfullin on 03/07/2021.
//

import CoreLocation

struct UnsplashPhoto: Decodable {
    let results: [PhotosCollectionModel]
}

struct PhotosCollectionModel: Decodable {
    let id: String
    let width: Int
    let height: Int
    let user: User
	let urls: Links
}

struct User: Decodable {
	let name: String
}

struct Links: Decodable {
	let regular: String
}


