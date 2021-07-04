//
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

class PhotosCollectionView: UIView {
    fileprivate(set) lazy var customView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(customView)
    }

    private func makeConstraints() {
    }
}
