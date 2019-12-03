//
//  FriendStartController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 29/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class FriendStartController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    var friends = [
    Person(image: UIImage(named: "friendInternet")!, name: "John", surname: "Wall"),
    Person(image: UIImage(named: "david1")!, name: "Timofey", surname: "Mozgov", photos: [
    UIImage(named: "david2")!,
    UIImage(named: "david3")!]),
    Person(image: UIImage(named: "david4")!, name: "Steven", surname: "Adams", photos: [
    UIImage(named: "david5")!])
    ]

    var filteredPersons = [Character: [Person]]()
    var filteredSearch = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filteredPersons = sort(friends: friends)
    }
    
    private func sort(friends: [Person]) -> [Character: [Person]] {
        var personDict = [Character : [Person]]()
        
        friends
            .sorted { $0.surname < $1.surname}
            .forEach { person in
            guard let firstChar = person.surname.first else { return }
            if var thisCharPersons = personDict[firstChar] {
                thisCharPersons.append(person)
                personDict[firstChar] = thisCharPersons
            } else {
                personDict[firstChar] = [person]
            }
        }
        return personDict
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredPersons.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstChar = filteredPersons.keys.sorted()[section]
        return String(firstChar)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = filteredPersons.keys.sorted()
        return filteredPersons[keysSorted[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendStartCell", for: indexPath) as? FriendStartCell else { preconditionFailure("FriendStartCell cannot be dequeued") }
        let firstChar = filteredPersons.keys.sorted()[indexPath.section]
        let friends = filteredPersons[firstChar]!
        let friend: Person = friends[indexPath.row]
        cell.FriendStartLabel.text = "\(friend.name) \(friend.surname)"
        cell.FriendStartImageView.image = friend.image
            
        return cell
    }
}

extension FriendStartController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBar.placeholder = " Search..."
           if searchText.isEmpty {
                filteredSearch = friends
            } else {
            filteredSearch = friends.filter{ $0.name.contains(searchText) || $0.surname.contains(searchText)}
            }
        filteredPersons = sort(friends: filteredSearch)
        self.tableView.reloadData()
    }
}

extension FriendStartController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show friend",
            let allPhotosVC = segue.destination as? FriendController,
            let selectedCellindexPath = tableView.indexPathForSelectedRow {
            
            let firstChar = filteredPersons.keys.sorted()[selectedCellindexPath.section]
            let photos = filteredPersons[firstChar]!
            let selectedfriend = photos[selectedCellindexPath.row]
            
            allPhotosVC.friendImages = selectedfriend.photos
        }
    }
}
