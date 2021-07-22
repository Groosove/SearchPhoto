//
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

struct UnsplashPhoto: Decodable {
    var results: [PhotosCollectionModel]
}

struct PhotosCollectionModel: Decodable {
    let uid: String
    let width: CGFloat
    let height: CGFloat
    let blurHash: String
    let user: User
	let urls: Links

	enum CodingKeys: String, CodingKey {
		case uid = "id"
		case width
		case height
		case blurHash = "blur_hash"
		case user
		case urls
	}
}

struct User: Decodable {
	let name: String
}

struct Links: Decodable {
	let regular: String
}
