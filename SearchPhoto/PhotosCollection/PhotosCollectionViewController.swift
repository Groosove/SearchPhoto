//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit
import CoreData

protocol PhotosCollectionDisplayLogic: AnyObject {
    func displaySomething(viewModel: PhotosCollection.LoadImages.ViewModel)
}

protocol PhotosCollectionViewControllerDelegate: AnyObject {
    func openViewer(with model: PhotoViewerModel)
    func updateSearchResults(with text: String)
    func deleteAllRecents()
}

class PhotosCollectionViewController: UIViewController {
    private let recentData = Container.shared.setModel(with: "Recent").coreDataStack
    private let frc: NSFetchedResultsController<Recent> = {
        let request = NSFetchRequest<Recent>(entityName: "Recent")
        request.sortDescriptors = [.init(key: "search", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request,
                                      managedObjectContext: Container.shared.coreDataStack.viewContext,
                                      sectionNameKeyPath: nil,
                                      cacheName: nil)
    }()
    let interactor: PhotosCollectionBusinessLogic
    var state: PhotosCollection.ViewControllerState
    var tableView: PhotosTablieView
    var recentTableView: RecentTableView!
	let tableDataSource = PhotosTableViewDataStore()
	let tableHandler = PhotosTableViewDelegate()
	let recentTableDataSource = RecentTableViewDataStore()
    let recentTableHandler = RecentTableViewDelegate()

    init(interactor: PhotosCollectionBusinessLogic, initialState: PhotosCollection.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        recentTableView = RecentTableView(frame: UIScreen.main.bounds)
        tableView = PhotosTablieView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpNavigationBar()
		setUpSearchBar()
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		if !recentTableView.isDescendant(of: self.view) {
			view.addSubview(recentTableView)
			updateRecents()
		}
	}

    // MARK: - Find Photo
    func findPhoto(with search: String) {
        let request = PhotosCollection.LoadImages.Request(search: search)
        interactor.findPhoto(request: request)
        recentData.viewContext.performAndWait {
            let recents = recentData.getAllRecents()
            guard (recents.filter { $0.search == search }).count == 0 else { return }
            let recent = Recent(context: recentData.viewContext)
            recent.search = search
            try? recentData.viewContext.save()
        }
        try? frc.performFetch()
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
    func displaySomething(viewModel: PhotosCollection.LoadImages.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: PhotosCollection.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
			createActivity(message: message)
        case let .result(items):
			tableHandler.models = items
			tableDataSource.models = items
            tableHandler.delegate = self
			tableView.updateTableViewData(delegate: tableHandler,
                                          dataSource: tableDataSource,
                                          tabBarHeight: tabBarController?.tabBar.frame.height ?? 44)
        case .emptyResult:
            createActivity(message: "Nothing was found for this result")
			tableView.removeFromSuperview()
			view.addSubview(recentTableView)
			recentData.deleteLastRecents()
			updateRecents()
        }
    }

	private func createActivity(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
									  style: .default,
									  handler: { _ in NSLog("The \"OK\" alert occured.")}))
		self.present(alert, animated: true, completion: nil)
	}
}

extension PhotosCollectionViewController: UISearchBarDelegate {
	private func setUpSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.searchBar.tintColor = .white
		searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.clearButtonMode = .never
		searchController.searchBar.delegate = self
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !tableView.isDescendant(of: self.view) {
            view.addSubview(tableView)
        }
		recentTableView.isHidden = true
        findPhoto(with: searchBar.text!.capitalized)
	}

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.removeFromSuperview()
		recentTableView.isHidden = false
        updateRecents()
    }

    private func updateRecents() {
        recentData.backgroundContext.performAndWait {
            let recents = recentData.getAllRecents()
            recentTableView.isHidden = recents.count == 0
            recentTableDataSource.models = recents
            recentTableHandler.models = recents
            recentTableHandler.delegate = self
            recentTableView.updateTableViewData(delegate: recentTableHandler,
                                                dataSource: recentTableDataSource)
        }
    }
}

extension PhotosCollectionViewController: PhotosCollectionViewControllerDelegate {
    func openViewer(with model: PhotoViewerModel) {
        let rootVC = PhotoViewerController(with: model)
        let navVC = CustomNavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
		navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true)
	}

    func deleteAllRecents() {
        recentData.deleteAllRecents()
        try? frc.performFetch()
        updateRecents()
    }

    func updateSearchResults(with text: String) {
        navigationItem.searchController?.searchBar.text = text
        searchBarSearchButtonClicked(navigationItem.searchController!.searchBar)
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
}
