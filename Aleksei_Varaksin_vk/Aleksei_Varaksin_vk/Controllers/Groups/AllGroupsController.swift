//
//  AllController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.showsCancelButton = false
        }
    }
    public var groups = [Group]()
    private let networkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.grouprecomend() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(group):
                self.groups = group
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
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
        cell.configure(with: group)

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
