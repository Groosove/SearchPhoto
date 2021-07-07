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
    let tableView: PhotosTablieView
	var tableDataSource = PhotosTableViewDataStore()
	var tableHandler = PhotosTableViewDelegate()
	
    init(interactor: PhotosCollectionBusinessLogic, initialState: PhotosCollection.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
		tableView = PhotosTablieView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }


    // MARK: View lifecycle
    override func loadView() {
		let collectionView = PhotosCollectionView(frame: UIScreen.main.bounds)
        self.view = collectionView
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpNavigationBar()
		setUpSearchBar()
    }

    // MARK: Find Photo
	func findPhoto(with search: String) {
        let request = PhotosCollection.Something.Request(search: search)
        interactor.findPhoto(request: request)
    }
	
	private func setUpNavigationBar() {
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.barTintColor = .black
		navigationItem.hidesSearchBarWhenScrolling = true
	}
	
	
	required init?(coder aDecoder: NSCoder) {
	 fatalError("init(coder:) has not been implemented")
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
			tableHandler.models = items
			tableDataSource.models = items
			let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: self.tabBarController!.tabBar.frame.height, left: 0, bottom: 0, right: 0);
			tableView.updateTableViewData(delegate: tableHandler, dataSource: tableDataSource)
			view.addSubview(tableView)
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
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.tintColor = .white
		searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.clearButtonMode = .never
		searchController.searchBar.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		findPhoto(with: searchBar.text!)
	}
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.removeFromSuperview()
    }
}
