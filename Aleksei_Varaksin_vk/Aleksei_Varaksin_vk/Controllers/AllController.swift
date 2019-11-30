//
//  AllController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class AllController: UITableViewController {

    let groups = [
    Group(image: UIImage(named: "groupgeek")!, name: "HSE"),
    Group(image: UIImage(named: "groupgeek")!, name: "Moscow"),
    Group(image: UIImage(named: "groupgeek")!, name: "Sports.ru")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicGroupCell", for: indexPath) as? BasicGroupCell else { preconditionFailure("BasicGroupCell cannot be dequeued") }
        let groupimage = groups[indexPath.row].image
        let groupname = groups[indexPath.row].name
        cell.basicgroupnameLabel.text = groupname
        cell.basicgroupImageView.image = groupimage

        return cell
    }

}
