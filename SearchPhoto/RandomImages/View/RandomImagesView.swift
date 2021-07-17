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
    weak var delegate: RandomImagesViewControllerDelegate?
    
    fileprivate(set) lazy var collectionView: UICollectionView = {
        let layout = WaterfallLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.delegate = delegate as? WaterfallLayoutDelegate
        view.register(RandomImagesViewCell.self, forCellWithReuseIdentifier: RandomImagesViewCell.identifier)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.contentInsetAdjustmentBehavior = .automatic
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }

    func addSubviews(){
        addSubview(collectionView)
    }

    func makeConstraints() {
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    
    func updateCollectioViewData(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
