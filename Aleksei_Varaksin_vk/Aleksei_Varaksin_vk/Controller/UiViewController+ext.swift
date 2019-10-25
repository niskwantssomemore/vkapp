//
//  UiViewController+ext.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 22/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func show(message: String) {
        let alertVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
