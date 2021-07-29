//
//  Created by Artur Lutfullin on 17/07/2021.
//

import UIKit

extension RandomImagesView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
    }
}

final class RandomImagesView: UIView {
    private let appearance = Appearance()
    weak var delegate: RandomImagesViewControllerDelegate?
    private lazy var collectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.delegate = delegate as? WaterfallLayoutDelegate
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.register(RandomImagesViewCell.self, forCellWithReuseIdentifier: RandomImagesViewCell.identifier)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.contentInsetAdjustmentBehavior = .automatic
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(frame: CGRect = CGRect.zero, delegate: RandomImagesViewControllerDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        addSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCollectioViewData(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
    }

    private func makeConstraints() {
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}
