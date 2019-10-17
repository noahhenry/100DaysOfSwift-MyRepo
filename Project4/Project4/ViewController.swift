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
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
		
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		
		progressView = UIProgressView(progressViewStyle: .)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		
		toolbarItems = [progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false
		
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		
		let url = URL(string: "https://www.hackingwithswift.com")!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}
	
	@objc func openTapped() {
		let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
		ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // important for iPad use.
		
		present(ac, animated: true)
	}

	func openPage(action: UIAlertAction) {
		// let url = URL(string: "https://" + action.title!)! // doulbe force-unwrap -> 1. because we know our 'alert action' will have a title and 2. because we know the finished string will be a valid url. We could use a guard let just to be safe.
		// guard let way
		guard let actionTitle = action.title else { return }
		guard let url = URL(string: "https://" + actionTitle) else { return }
		
		webView.load(URLRequest(url: url))
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
}
