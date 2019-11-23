//
//  NavigationController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 23/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = InteractiveAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .push) {
            interactiveTransition.viewController = toVC
            return PushAnimation()
        } else if (operation == .pop) {
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopAnimation()
        }
        return nil
    }
}
