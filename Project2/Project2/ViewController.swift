//
//  ViewController.swift
//  Project2
//
//  Created by Henry, Noah on 10/11/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!
	
	var countries = [String]()
	var scores = 0
	var correctAnswer = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
//		countries.append("estonia")
//		countries.append("france")
//		countries.append("germany")
//		countries.append("ireland")
//		countries.append("italy")
//		countries.append("monaco")
//		countries.append("nigeria")
//		countries.append("poland")
//		countries.append("russia")
//		countries.append("spain")
//		countries.append("uk")
//		countries.append("us")
		
		// instead of the above, we can do this all on 1 line...
		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		
		// Button Styles
		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1
		
		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		button3.layer.borderColor = UIColor.lightGray.cgColor
		
		askQuestion()
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		
		title = countries[correctAnswer].uppercased()
	}


}

