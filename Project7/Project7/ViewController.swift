//
//  ViewController.swift
//  Project7
//
//  Created by Henry, Noah on 12/18/19.
//  Copyright © 2019 hackingwithswift. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var petitions = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = "Title goes here"
		cell.detailTextLabel?.text = "Subtitle goes here"
		return cell
	}

}

