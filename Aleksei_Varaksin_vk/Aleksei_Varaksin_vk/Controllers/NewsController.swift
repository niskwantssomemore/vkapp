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
    var nextFrom = ""
    var isLoading = false
    private let photoService = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getNewsList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(news, nextFrom):
                self.newsList = news
                self.nextFrom = nextFrom
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
        tableView.prefetchDataSource = self
        setupRefreshControl()
    }
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .systemGreen
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    @objc private func refreshNews() {
        let startTime = newsList.first?.date ?? Date().timeIntervalSince1970
        networkService.getNewsList(startTime: startTime + 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(news, _):
                self.newsList = news + self.newsList
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            self.refreshControl?.endRefreshing()
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
extension NewsController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > newsList.count - 3,
            !isLoading {
            isLoading = true
            networkService.getNewsList(startFrom: nextFrom) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(news, nextFrom):
                    let startIndex = self.newsList.count
                    let endIndex = self.newsList.count + news.count
                    let indexSet = IndexSet(integersIn: startIndex ..< endIndex)
                    
                    self.newsList.append(contentsOf: news)
                    self.nextFrom = nextFrom

                    self.tableView.insertSections(indexSet, with: .none)
                case let .failure(error):
                    print(error)
                }
                self.isLoading = false
            }
        }
    }
}
