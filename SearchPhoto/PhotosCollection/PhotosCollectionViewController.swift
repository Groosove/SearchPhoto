//
//  PhotosCollection module
//  Created by Artur Lutfullin on 03/07/2021.
//

import UIKit
import CoreData

protocol PhotosCollectionDisplayLogic: AnyObject {
    func displaySomething(viewModel: PhotosCollection.Something.ViewModel)
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
    let tableView: PhotosTablieView
    let recentTableView: RecentTableView
	var tableDataSource = PhotosTableViewDataStore()
	var tableHandler = PhotosTableViewDelegate()
	var recentTableDataSource = RecentTableViewDataStore()
    var recentTableHandler = RecentTableViewDelegate()
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
        updateRecents()
        recentTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: -- Find Photo
    func findPhoto(with search: String) {
        let request = PhotosCollection.Something.Request(search: search)
        interactor.findPhoto(request: request)
        recentData.viewContext.performAndWait {
            let recents = recentData.getArrayData()
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
            tableHandler.delegate = self
			tableView.updateTableViewData(delegate: tableHandler,
                                          dataSource: tableDataSource,
                                          tabBarHeight: tabBarController?.tabBar.frame.height ?? 44)
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
        findPhoto(with: searchBar.text!.capitalized)
	}
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.removeFromSuperview()
        view.addSubview(recentTableView)
        updateRecents()
    }
    
    private func updateRecents() {
        recentData.backgroundContext.performAndWait {
            let recents = recentData.getArrayData()
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
        navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(rootVC, animated: true)
	}
    
    func deleteAllRecents() {
        recentData.deleteAll()
        try? frc.performFetch()
        updateRecents()
    }
    
    func updateSearchResults(with text: String) {
        navigationItem.searchController?.searchBar.text = text
        searchBarSearchButtonClicked(navigationItem.searchController!.searchBar)
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
}

