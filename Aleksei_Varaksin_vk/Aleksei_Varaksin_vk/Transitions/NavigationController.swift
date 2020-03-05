//
//  NavigationController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 23/11/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let edgePanGR = UIPanGestureRecognizer(target: self, action: #selector(handleEdgeGesture(_:)))
        view.addGestureRecognizer(edgePanGR)
    }
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimation()
        case .pop:
            return PopAnimation()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
    @objc func handleEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.33
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        default: return
        }
    }
}
