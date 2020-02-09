//
//  NewsController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 09/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class NewsController: UITableViewController {
    private let networkService = NetworkService()
    var newsList = [News]()
    private let photoService = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getNewsList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(news):
                self.newsList = news
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsList.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newsCell: News?
        if newsList.indices.contains(indexPath.section) {
            newsCell = newsList[indexPath.section]
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            if let news = newsCell {
                cell.configure(with: news, indexPath: indexPath, using: photoService)
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            if let news = newsCell {
                cell.configure(with: news, indexPath: indexPath, using: photoService)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikeCell", for: indexPath) as! LikeCell
            if let news = newsCell {
                cell.configure(with: news, indexPath: indexPath)
            }
            return cell
        }
    }
}
