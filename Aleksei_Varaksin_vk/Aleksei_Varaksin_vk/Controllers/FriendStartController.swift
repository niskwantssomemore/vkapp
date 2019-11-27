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
    Person(image: UIImage(named: "friendInternet")!, name: "Timofey", surname: "Mozgov"),
    Person(image: UIImage(named: "friendInternet")!, name: "Steven", surname: "Adams")
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

    // MARK: - Table view data source

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show friend",
            let destinationVC = segue.destination as? FriendController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            let friendname = friends[indexPath.row].name
            destinationVC.title = friendname
        }
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
