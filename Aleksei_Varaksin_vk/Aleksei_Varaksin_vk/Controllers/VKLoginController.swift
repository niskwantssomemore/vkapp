//
//  VKLoginController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 04/12/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7233202"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        Session.shared.token = token
        performSegue(withIdentifier: "Run the App", sender: nil)
        
        decisionHandler(.cancel)
    }
}
