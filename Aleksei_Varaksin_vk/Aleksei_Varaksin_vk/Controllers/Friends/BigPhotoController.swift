//
//  BigPhotoController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 03/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import Kingfisher

class BigPhotoController: UIViewController {
    enum AnimationDirection {
        case left
        case right
    }    
    @IBOutlet var bigPhotoImageView: UIImageView! {
        didSet {
            bigPhotoImageView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet var additionalImageView: UIImageView!
    public var photos: [Photo] = []
    public var selectedPhotoIndex: Int = 0
    private var propertyAnimator: UIViewPropertyAnimator!
    private var animationDirection: AnimationDirection = .left

    override func viewDidLoad() {
        super.viewDidLoad()

        guard !photos.isEmpty else { return }
        bigPhotoImageView.kf.setImage(with: URL(string: photos[selectedPhotoIndex].image))
        
        let leftSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(photoSwipedLeft(_:)))
        leftSwipeGR.direction = .left
        bigPhotoImageView.addGestureRecognizer(leftSwipeGR)
        let rightSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(photoSwipedRight(_:)))
        rightSwipeGR.direction = .right
        bigPhotoImageView.addGestureRecognizer(rightSwipeGR)
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        view.addGestureRecognizer(panGR)
    }
    @objc func photoSwipedLeft(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        guard selectedPhotoIndex + 1 <= photos.count - 1 else { return }
        
        additionalImageView.transform = CGAffineTransform(translationX: 1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
        additionalImageView.kf.setImage(with: URL(string: photos[selectedPhotoIndex + 1].image))
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.bigPhotoImageView.transform = CGAffineTransform(translationX: -1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        }) { _ in
            self.selectedPhotoIndex += 1
            self.bigPhotoImageView.kf.setImage(with: URL(string: self.photos[self.selectedPhotoIndex].image))
            self.bigPhotoImageView.transform = .identity
            self.additionalImageView.image = nil
        }
    }
    @objc func photoSwipedRight(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        guard selectedPhotoIndex >= 1 else { return }
        
        additionalImageView.transform = CGAffineTransform(translationX: -1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
        additionalImageView.kf.setImage(with: URL(string: photos[selectedPhotoIndex - 1].image))
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.bigPhotoImageView.transform = CGAffineTransform(translationX: 1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        }) { _ in
            self.selectedPhotoIndex -= 1
            self.bigPhotoImageView.kf.setImage(with: URL(string: self.photos[self.selectedPhotoIndex].image))
            self.bigPhotoImageView.transform = .identity
            self.additionalImageView.image = nil
        }
    }    
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        switch panGestureRecognizer.state {
        case .began:
            if panGestureRecognizer.translation(in: view).x > 0 {
                guard selectedPhotoIndex >= 1 else { return }
                
                animationDirection = .right
                additionalImageView.transform = CGAffineTransform(translationX: -1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                additionalImageView.kf.setImage(with: URL(string: photos[selectedPhotoIndex - 1].image))
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.bigPhotoImageView.transform = CGAffineTransform(translationX: 1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                })
                propertyAnimator.addCompletion { position in
                    switch position {
                    case .end:
                        self.selectedPhotoIndex -= 1
                        self.bigPhotoImageView.kf.setImage(with: URL(string: self.photos[self.selectedPhotoIndex].image))
                        self.bigPhotoImageView.transform = .identity
                        self.additionalImageView.image = nil
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: -1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                guard selectedPhotoIndex + 1 <= photos.count - 1 else { return }
                
                animationDirection = .left
                additionalImageView.kf.setImage(with: URL(string: photos[selectedPhotoIndex + 1].image))
                additionalImageView.transform = CGAffineTransform(translationX: 1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.bigPhotoImageView.transform = CGAffineTransform(translationX: -1.5*self.bigPhotoImageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                })
                propertyAnimator.addCompletion { position in
                    switch position {
                    case .end:
                        self.selectedPhotoIndex += 1
                        self.bigPhotoImageView.kf.setImage(with: URL(string: self.photos[self.selectedPhotoIndex].image))
                        self.bigPhotoImageView.transform = .identity
                        self.additionalImageView.image = nil
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: 1.3*self.additionalImageView.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            }
        case .changed:
            guard let propertyAnimator = self.propertyAnimator else { return }
            switch animationDirection {
            case .right:
                let percent = min(max(0, panGestureRecognizer.translation(in: view).x / 200), 1)
                propertyAnimator.fractionComplete = percent
            case .left:
                let percent = min(max(0, -panGestureRecognizer.translation(in: view).x / 200), 1)
                propertyAnimator.fractionComplete = percent
            }
        case .ended:
            guard let propertyAnimator = self.propertyAnimator else { return }
            bigPhotoImageView.isUserInteractionEnabled = false
            if propertyAnimator.fractionComplete > 0.33 {
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
        default:
            break
        }
    }
}
