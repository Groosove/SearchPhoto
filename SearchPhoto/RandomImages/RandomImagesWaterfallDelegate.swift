//
//  RandomImagesWaterfallDelegate.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/17/21.
//

import UIKit

class RandomImagesWaterfallDelegate: NSObject, UICollectionViewDelegate {
    var models: [PhotosCollectionModel]
    
    init(models: [PhotosCollectionModel] = []) {
        self.models = models
    }
}
