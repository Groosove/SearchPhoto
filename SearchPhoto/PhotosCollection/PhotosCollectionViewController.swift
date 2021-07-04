//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol PhotosCollectionDisplayLogic: AnyObject {
    func displaySomething(viewModel: PhotosCollection.Something.ViewModel)
}

class PhotosCollectionViewController: UIViewController {
    let interactor: PhotosCollectionBusinessLogic
    var state: PhotosCollection.ViewControllerState
	
	
    init(interactor: PhotosCollectionBusinessLogic, initialState: PhotosCollection.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
		let collectionView = PhotosCollectionView(frame: UIScreen.main.bounds)
        self.view = collectionView
		view.backgroundColor = .black
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
		setUpNavigationBar()
		setUpSearchBar()
    }

    // MARK: Do something
    func doSomething() {
        let request = PhotosCollection.Something.Request(search: "programming")
        interactor.doSomething(request: request)
    }
	
	private func setUpNavigationBar() {
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.barTintColor = .black
		navigationItem.hidesSearchBarWhenScrolling = true
	}
}

extension PhotosCollectionViewController: PhotosCollectionDisplayLogic {
    func displaySomething(viewModel: PhotosCollection.Something.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: PhotosCollection.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
            print("error \(message)")
        case let .result(items):
            items.forEach { print($0.links.download) }
        case .emptyResult:
            print("empty result")
        }
    }
}

extension PhotosCollectionViewController: UISearchBarDelegate {
	private func setUpSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		searchController.hidesNavigationBarDuringPresentation = true
		searchController.obscuresBackgroundDuringPresentation = true
		searchController.searchBar.tintColor = .white
		searchController.searchBar.searchTextField.textColor = .white
		searchController.searchBar.delegate = self
		
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print(searchBar)
	}
}
