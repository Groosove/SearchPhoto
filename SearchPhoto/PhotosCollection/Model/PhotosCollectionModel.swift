//
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

struct UnsplashPhoto: Decodable {
    var results: [PhotosCollectionModel]
}

struct PhotosCollectionModel: Decodable {
    let id: String
    let width: CGFloat
    let height: CGFloat
    let blur_hash: String
    let user: User
	let urls: Links
}

struct User: Decodable {
	let name: String
}

struct Links: Decodable {
	let regular: String
}


