//
//  ViewController.swift
//  Project1
//
//  Created by Henry, Noah on 10/10/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var pictures = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		for item in items {
			if item.hasPrefix("nssl") {
				// this is a picture to load!
				pictures.append(item)
			}
		}
		
		print(pictures)
	}


}

