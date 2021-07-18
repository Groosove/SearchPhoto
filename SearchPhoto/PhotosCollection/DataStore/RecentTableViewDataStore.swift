//
//  RecentTableViewDataStore.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/10/21.
//

import UIKit

class RecentTableViewDataStore: NSObject, UITableViewDataSource {
    var models: [Recent]
    init (models: [Recent] = []) {
        self.models = models
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier, for: indexPath) as? RecentTableViewCell
        guard let recent = cell else { return UITableViewCell() }
        recent.configure(recent: models[indexPath.row].search)
        return recent
    }
}
