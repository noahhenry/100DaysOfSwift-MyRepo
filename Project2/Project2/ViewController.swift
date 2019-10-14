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
	var score = 0
	var correctAnswer = 0
	var numberOfQuestionsAsked = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Adds a button in the upper right of the Navigation
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScore))
		
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
	
	func randomize() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		
		// gets set after randomization so that the flag value is the same as the correct answer.
		title = "Score: \(score) | Flag: \(countries[correctAnswer].uppercased())"
	}
	
	func askQuestion(action: UIAlertAction! = nil) {
		numberOfQuestionsAsked += 1
		// print("Questions Asked Count: \(numberOfQuestionsAsked)")
		
		if numberOfQuestionsAsked == 11 {
			print("Show Final Score")
			let ac2 = UIAlertController(title: "Your Final Score", message: "\(score)", preferredStyle: .alert)
			
			ac2.addAction(UIAlertAction(title: "Play Again", style: .default, handler: reset))
			
			present(ac2, animated: true)
		} else {
			randomize()
		}
	}
	
	func reset(action: UIAlertAction! = nil) {
		score = 0
		numberOfQuestionsAsked = 0
		randomize()
	}

	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
		
		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
		} else {
			title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())."
			score -= 1
		}
		
		let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
		
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		
		present(ac, animated: true)
	}
	
	@objc func showScore() {
		let vc = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
		vc.addAction(UIAlertAction(title: "Dismiss", style: .default))
		present(vc, animated: true)
	}
}

