//
//  FriendStartController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 29/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import RealmSwift

class AllFriendsController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = " Search..."
            searchBar.delegate = self
        }
    }
    private let networkService = NetworkService()
    var myFriends: Results<User>?
    var filteredFriends: Results<User>?
    var notificationToken: NotificationToken?
    var firstLettersArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myFriends = RealmService.get(User.self)
        notificationToken = myFriends?.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                let searchText = self.searchBar.text ?? ""
                guard let filteredFriends = self.updateFilteredFriends(searchText: searchText) else { return }
                self.filteredFriends = filteredFriends
                self.firstLettersArray = self.prepareFirstLettersArray(filteredFriends: filteredFriends)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
        networkService.frienduser() { myFriends in
            RealmService.save(items: myFriends)
        }
    }
    fileprivate func updateFilteredFriends(searchText: String) -> Results<User>? {
        if !searchText.isEmpty {
            return RealmService.get(User.self)?.filter("last_name CONTAINS[cd] %@ OR first_name CONTAINS[cd] %@ ", searchText, searchText).sorted(byKeyPath: "last_name")
        } else {
            return RealmService.get(User.self)?.sorted(byKeyPath: "last_name")
        }
    }
    fileprivate func prepareFirstLettersArray(filteredFriends: Results<User>) -> [String] {
        let firstLetters = filteredFriends.compactMap { $0.last_name.first }.map { String($0) }
        return Array(Set(firstLetters)).sorted()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstLettersArray.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        firstLettersArray[section]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstLetter = firstLettersArray[section]
        return filteredFriends?.filter("last_name BEGINSWITH[cd] %@", firstLetter).count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendStartCell", for: indexPath) as? FriendStartCell else { preconditionFailure("FriendStartCell cannot be dequeued") }
        let firstLetter = firstLettersArray[indexPath.section]
        if let users = filteredFriends?.filter("last_name BEGINSWITH[cd] %@", firstLetter) {
            cell.configure(with: users[indexPath.row])
        }
            
        return cell
    }
}
extension AllFriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let filteredFriends = updateFilteredFriends(searchText: searchText) else { return }
        self.filteredFriends = filteredFriends
        firstLettersArray = prepareFirstLettersArray(filteredFriends: filteredFriends)
        tableView.reloadData()
    }
}
extension AllFriendsController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show friend",
            let allPhotosVC = segue.destination as? FriendController,
            let selectedCellindexPath = tableView.indexPathForSelectedRow {

//            let firstChar = filteredPersons.keys.sorted()[selectedCellindexPath.section]
//            let photos = filteredPersons[firstChar]!
//            let selectedfriend = photos[selectedCellindexPath.row]
            if let users = myFriends {
                allPhotosVC.friendId = users[selectedCellindexPath.row].id
            }
        }
    }
}
