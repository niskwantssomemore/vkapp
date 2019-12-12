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
    Groups(image: UIImage(named: "groupgeek")!, name: "HSE"),
    Groups(image: UIImage(named: "groupgeek")!, name: "Moscow"),
    Groups(image: UIImage(named: "groupgeek")!, name: "Sports.ru")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let groupimage = groups[indexPath.row].image
        let groupname = groups[indexPath.row].name
        cell.basicgroupnameLabel.text = groupname
        cell.basicgroupImageView.image = groupimage

        return cell
    }

}
