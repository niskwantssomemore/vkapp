//
//  NetworkFetchOperation.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 26/01/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

class NetworkFetchOperation: AsyncOperation {
    var groups = [Group]()
    private let networkService = NetworkService()
    
    override func main() {
        networkService.groupuser() { [weak self] result in
            guard let self = self else { return }
            guard case let .success(groups) = result else { return }
            self.groups = groups
            self.state = .finished
        }
    }
}
