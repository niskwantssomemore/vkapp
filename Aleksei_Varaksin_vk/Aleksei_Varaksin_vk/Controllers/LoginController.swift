//
//  ViewController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 19/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var DefaultImageView: UIImageView!
    @IBOutlet var DefaultView: UIView!
    @IBOutlet var FirstTimeLabel: UILabel!
    @IBOutlet var PasswordTextfield: UITextField!
    @IBOutlet var LoginTextfield: UITextField!
    @IBOutlet var PasswordLabel: UILabel!
    @IBOutlet var LoginLabel: UILabel!
    @IBOutlet var VKLabel: UILabel!
    @IBOutlet var loadIndicator1: LoadView!
    @IBOutlet var loadIndicator2: LoadView!
    @IBOutlet var loadIndicator3: LoadView!
    
    var delay: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGR)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loadIndicators = [loadIndicator1, loadIndicator2, loadIndicator3]
        
        for indicator in loadIndicators {
            if let loadindicator = indicator {
                UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat,.autoreverse], animations: {
                    self.loadanimations(loadindicator, delay: CFTimeInterval(self.delay))
                }, completion: nil)
            }
            self.delay += 0.5
        }
        self.delay = 0
    }
    
    private func loadanimations(_ sender: UIView, delay: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 1
        animation.fillMode = .removed
        animation.autoreverses = true
        animation.repeatCount = .infinity
        sender.layer.add(animation, forKey: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    @IBAction func LoginButton(_ sender: Any) {
        guard let login = LoginTextfield.text,
            let password = PasswordTextfield.text,
        login == "",
            password == "" else {show(message: "Incorrect login/password")
                return
        }
        performSegue(withIdentifier: "Login Segue", sender: nil)
    }
    @IBAction func ForgotButton(_ sender: Any) {
    }
    @IBAction func SignupButton(_ sender: Any) {
    }
    @objc func willShowKeyboard(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
        let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else { return }
        let keyboardHeight = keyboardSize.cgRectValue.size.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    @objc func willHideKeyboard(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    @objc func viewTapped() {
        view.endEditing(true)
    }
}
