//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit
import CoreData

protocol PhotosCollectionDisplayLogic: AnyObject {
    func displayImages(viewModel: PhotosCollection.LoadImages.ViewModel)
}

protocol PhotosCollectionViewControllerDelegate: AnyObject {
    func openViewer(with model: PhotoViewerModel)
    func updateSearchResults(with text: String)
    func deleteAllRecents()
}

final class PhotosCollectionViewController: UIViewController {
    // MARK: - Properties
    private let recentData = Container.shared.coreDataStack
    private let frc: NSFetchedResultsController<Recent> = {
        let request = NSFetchRequest<Recent>(entityName: "Recent")
        request.sortDescriptors = [.init(key: "search", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request,
                                      managedObjectContext: Container.shared.coreDataStack.viewContext,
                                      sectionNameKeyPath: nil,
                                      cacheName: nil)
    }()
    private let interactor: PhotosCollectionBusinessLogic
    private var state: PhotosCollection.ViewControllerState
    private var tableView: PhotosTablieView!
    private var recentTableView: RecentTableView!
	private let tableDataSource = PhotosTableViewDataStore()
	private let tableHandler = PhotosTableViewDelegate()
	private let recentTableDataSource = RecentTableViewDataStore()
    private let recentTableHandler = RecentTableViewDelegate()

    // MARK: - Init
    init(interactor: PhotosCollectionBusinessLogic, initialState: PhotosCollection.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpNavigationBar()
		setUpSearchBar()
    }

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
        if recentTableView == nil {
            recentTableView = RecentTableView(frame: view.bounds)
        }

        if tableView == nil {
            tableView = PhotosTablieView(frame: view.bounds)
        }

		if !recentTableView.isDescendant(of: self.view) {
			view.addSubview(recentTableView)
			updateRecents()
		}

        if !tableView.isDescendant(of: self.view) {
            view.addSubview(tableView)
            tableView.isHidden = true
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

    // MARK: Setup UI
    private func setUpNavigationBar() {
		navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = "Search Images"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		navigationItem.hidesSearchBarWhenScrolling = true
	}

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

}

// MARK: - PhotosCollectionDisplayLogic
extension PhotosCollectionViewController: PhotosCollectionDisplayLogic {
    func displayImages(viewModel: PhotosCollection.LoadImages.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: PhotosCollection.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
			createActivity(with: self, message: message)
        case let .result(items):
			tableView.isHidden = false
			recentTableView.isHidden = true
			tableHandler.models = items
			tableDataSource.models = items
            tableHandler.delegate = self
			tableView.updateTableViewData(delegate: tableHandler, dataSource: tableDataSource)
        case .emptyResult:
            createActivity(with: self, message: "Nothing was found for this result")
            tableView.isHidden = true
            recentTableView.isHidden = false
			recentData.deleteLastRecents()
			updateRecents()
        }
    }
}

// MARK: - UISearchBarDelegate
extension PhotosCollectionViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		findPhoto(with: searchBar.text!.capitalized)
	}

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
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

// MARK: - PhotosCollectionViewControllerDelegate
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
