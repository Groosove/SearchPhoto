//
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

extension RandomImagesView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
    }
}

class RandomImagesView: UIView {
    let appearance = Appearance()

    fileprivate(set) lazy var customView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews(){
        addSubview(customView)
    }

    func makeConstraints() {
    }
}
