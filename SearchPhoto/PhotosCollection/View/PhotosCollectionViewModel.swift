//
//  PhotosCollectionViewModel.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/24/21.
//

import UIKit

struct PhotosCollectionViewModel: Decodable {
    let uid: String
    let width: CGFloat
    let height: CGFloat
    let blurHash: String
    let name: String
    let imageURL: String
}
