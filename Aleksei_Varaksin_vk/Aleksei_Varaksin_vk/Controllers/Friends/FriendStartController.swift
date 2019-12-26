//
//  FriendStartController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 29/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import RealmSwift

class FriendStartController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    private let networkService = NetworkService()
    var myFriends: Results<User>?
    var notificationToken: NotificationToken?
    var filteredPersons = [Character: [User]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myFriends = RealmService.get(User.self)
        notificationToken = myFriends?.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_, _, _, _):
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
        networkService.frienduser() { myFriends in
            RealmService.save(items: myFriends)
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
//    private func sort(friends: [User]) -> [Character: [User]] {
//        var personDict = [Character : [User]]()
//
//        friends
//            .sorted { $0.last_name < $1.last_name}
//            .forEach { person in
//            guard let firstChar = person.last_name.first else { return }
//            if var thisCharPersons = personDict[firstChar] {
//                thisCharPersons.append(person)
//                personDict[firstChar] = thisCharPersons
//            } else {
//                personDict[firstChar] = [person]
//            }
//        }
//        return personDict
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return filteredPersons.keys.count
//    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let firstChar = filteredPersons.keys.sorted()[section]
//        return String(firstChar)
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let keysSorted = filteredPersons.keys.sorted()
//        return filteredPersons[keysSorted[section]]?.count ?? 0
        return myFriends?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendStartCell", for: indexPath) as? FriendStartCell else { preconditionFailure("FriendStartCell cannot be dequeued") }
//        let firstChar = filteredPersons.keys.sorted()[indexPath.section]
//        let friends = filteredPersons[firstChar]!
//        let friend: User = friends[indexPath.row]
//        cell.configure(with: friend)
        if let users = myFriends {
            cell.configure(with: users[indexPath.row])
        }
            
        return cell
    }
}
extension FriendStartController: UISearchBarDelegate {
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            searchBar.placeholder = " Search..."
//           if searchText.isEmpty {
//                filteredFriends = friends
//            } else {
//            filteredFriends = friends.filter{ $0.first_name.contains(searchText) || $0.last_name.contains(searchText)}
//            }
//        filteredPersons = sort(friends: filteredFriends)
//        self.tableView.reloadData()
//    }
}
extension FriendStartController {
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
