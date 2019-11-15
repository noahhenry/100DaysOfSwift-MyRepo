//
//  ViewController.swift
//  Project4
//
//  Created by Henry, Noah on 10/16/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
	var webView: WKWebView!
	var progressView: UIProgressView!
	var websites = ["apple.com", "hackingwithswift.com", "angular.io"]
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
		
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		
		toolbarItems = [progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false
		
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		
		let landingWebsite = websites[0]
		let url = URL(string: "https://" + landingWebsite)! // or string interpolation as -> let url = URL(string: "https://\(websites[0])")!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}
	
	@objc func openTapped() {
		let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
		
		for website in websites {
			ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
		}
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // important for iPad use.
		
		present(ac, animated: true)
	}

	func openPage(action: UIAlertAction) {
		// let url = URL(string: "https://" + action.title!)! // doulbe force-unwrap -> 1. because we know our 'alert action' will have a title and 2. because we know the finished string will be a valid url. We could use a 'guard let' just to be safe.
		// guard let way
		guard let actionTitle = action.title else { return }
		guard let url = URL(string: "https://" + actionTitle) else { return }
		
		webView.load(URLRequest(url: url))
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
	
	@objc func goBack() {
		webView.goBack()
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url
		
		if let host = url?.host {
			print("The Host: \(host)")
			for website in websites {
				if host.contains(website) {
					decisionHandler(.allow)
					return
				}
			}
		}
		
		// to stop "Unauthorized URL" alert from showing on links that are not "hackingwithswift.com"
		// there seems to be some from of rerouting happening on the other sites.
		let urlString = url?.absoluteString ?? "Unknown"
		if urlString != "about:blank" {
			// to test, select angular.io from the list and scroll to the footer and select the "Stack Overflow" link
			let ac = UIAlertController(title: "Unauthorized URL", message: "The URL you selected does not exist in our list of safe URLs.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
			present(ac, animated: true)
		}
		
		decisionHandler(.cancel)
	}
}
