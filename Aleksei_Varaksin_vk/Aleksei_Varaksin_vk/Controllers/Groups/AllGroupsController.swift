//
//  AllController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import RealmSwift

class AllGroupsController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.showsCancelButton = false
        }
    }
    public var groups = [Group]()
    private let photoService = PhotoService()
    let q = OperationQueue()
    private lazy var myRecommendGroups: Results<Group> = try! Realm(configuration: RealmService.deleteIfMigration).objects(Group.self)
    private let networkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let operation = NetworkFetchOperation()
        operation.completionBlock = { [weak self] in
            guard let self = self else { return }
            self.groups = operation.groups
        }
        q.addOperation(operation)
//        networkService.grouprecomend() { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(group):
//                try? RealmService.save(items: group, configuration: RealmService.deleteIfMigration, update: .all)
//                self.groups = group
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
//            case let .failure(error):
//                print(error)
//            }
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicGroupCell", for: indexPath) as? BasicGroupCell else { preconditionFailure("BasicGroupCell cannot be dequeued") }
        let group = groups[indexPath.row]
        cell.configure(with: group, using: photoService)
        return cell
    }
}
extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarFilter(search: searchText)
    }
    private func searchBarFilter(search text: String) {
        networkService.groupsearch(search: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(group):
                self.groups = group
                guard !group.isEmpty else { return }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
        tableView.reloadData()
    }
}
