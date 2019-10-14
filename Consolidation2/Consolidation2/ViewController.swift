//
//  ViewController.swift
//  Consolidation2
//
//  Created by Henry, Noah on 10/14/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	// -- Project 2 Methodology -- /
	// Create var to hold an array of the countries.
	var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

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
}

