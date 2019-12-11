//
//  FavouriteController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class FavouriteController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    private var groups = [Group]()
    private let networkService = NetworkService()
    var filteredGroups = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.groupuser() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(group):
                self.groups = group
                self.filteredGroups = group
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
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else { preconditionFailure("GroupCell cannot be dequeued") }
        let group = filteredGroups[indexPath.row]
        cell.configure(with: group)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

//    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
//        if let sourceVC = segue.source as? AllController,
//            let indexPath = sourceVC.tableView.indexPathForSelectedRow {
//            let group = sourceVC.groups[indexPath.row]
//            if !groups.contains(where: { $0.name == group.name}) {
//                groups.append(group)
//                filteredGroups = groups
//                tableView.reloadData()
//            }
//        }
//    }
}
extension FavouriteController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGroups = groups
        } else {
            filteredGroups = groups.filter { $0.name.contains(searchText) }
        }
        tableView.reloadData()
    }
}
