//
//  Created by Artur Lutfullin on 17/07/2021.
//

/// Модель данных, описывающая ...
struct RandomImagesModel: UniqueIdentifiable {
    // Example
    let uid: UniqueIdentifier
    let name: String
}

extension RandomImagesModel: Equatable {
    static func == (lhs: RandomImagesModel, rhs: RandomImagesModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
