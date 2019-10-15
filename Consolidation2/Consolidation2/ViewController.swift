//
//  ViewController.swift
//  Consolidation2
//
//  Created by Henry, Noah on 10/14/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	// -- Project 1 Methodology -- //
	// Create var to hold an empty array of pictures for the countries flags.
	var countries = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Get Images from the FileManager.
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		// Loop over each item in the countriesList array and push the item to the countries array if it
		// has a prefix of 'country-'.
		for item in items {
			if item.hasPrefix("country-") {
				// this is a picture to load!
				countries.append(item)
			}
		}
		
		print(countries)
	}
	
	// We need to tell the ViewController how many rows our table will have.
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries.count
	}

	// We need to tell the ViewController, what content will reside in each row.
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CountryFlag", for: indexPath)
		cell.textLabel?.text = countries[indexPath.row]
		cell.imageView?.image = UIImage(named: "\(countries[indexPath.row])")
		return cell
	}
	
	
	
//	// -- Project 2 Methodology -- /
//	// Create var to hold an array of the countries.
//	var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		// Do any additional setup after loading the view.
//
//		print(countries)
//	}
//
//	// We need to tell the ViewController how many rows our table will have.
//	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return countries.count
//	}
//
//	// We need to tell the ViewController, what content will reside in each row.
//	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: "CountryFlag", for: indexPath)
//		cell.textLabel?.text = countries[indexPath.row]
//		cell.imageView?.image = UIImage(named: "\(countries[indexPath.row])")
//		return cell
//	}
}

