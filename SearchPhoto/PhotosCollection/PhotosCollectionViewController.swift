//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit

protocol PhotosCollectionDisplayLogic: AnyObject {
    func displaySomething(viewModel: PhotosCollection.Something.ViewModel)
}

protocol PhotosCollectionViewControllerDelegate: AnyObject {
	func openViewer(uid: String)
}

class PhotosCollectionViewController: UIViewController {
    let recentData = Container.shared.setModel(with: "Recent").coreDataStack
    
    let interactor: PhotosCollectionBusinessLogic
    var state: PhotosCollection.ViewControllerState
    let tableView: PhotosTablieView
    let recentTableView: RecentTableView
	var tableDataSource = PhotosTableViewDataStore()
	var tableHandler = PhotosTableViewDelegate()
	
    init(interactor: PhotosCollectionBusinessLogic, initialState: PhotosCollection.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        recentTableView = RecentTableView(frame: UIScreen.main.bounds)
        tableView = PhotosTablieView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(recentTableView)
		setUpNavigationBar()
		setUpSearchBar()
        
    }

    // MARK: Find Photo
	func findPhoto(with search: String) {
        let request = PhotosCollection.Something.Request(search: search)
        interactor.findPhoto(request: request)
        recentData.backgroundContext.performAndWait {
            let recent = Recent(context: recentData.backgroundContext)
            recent.search = search
            try? recentData.backgroundContext.save()
        }
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
			tableView.updateTableViewData(delegate: tableHandler, dataSource: tableDataSource)
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
		if !tableView.isDescendant(of: self.view) {
			view.addSubview(tableView)
            
        }
        recentTableView.removeFromSuperview()
		findPhoto(with: searchBar.text!)
	}
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.removeFromSuperview()
        view.addSubview(recentTableView)
    }
}

extension PhotosCollectionViewController: PhotosCollectionViewControllerDelegate {
	func openViewer(uid: String) {
		
	}
}

