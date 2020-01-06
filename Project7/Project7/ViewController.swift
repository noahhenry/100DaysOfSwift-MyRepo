//
//  ViewController.swift
//  Project7
//
//  Created by Henry, Noah on 12/18/19.
//  Copyright © 2019 hackingwithswift. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var petitions = [Petition]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Credits Alert
		let creditsButton: UIBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
		self.navigationItem.rightBarButtonItem = creditsButton
		
		// Seting Up The URL
		// let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
		let urlString: String

		if navigationController?.tabBarItem.tag == 0 {
			// urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
			urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
		} else {
			// urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
			urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
		}
		
		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				// we're OK to parse
				parse(json: data)
				
				return
			}
		}
		
		showError()
	}
	
	@objc func showCredits() {
		let ac = UIAlertController(title: "Data Source", message: "The data used in this app is sourced from the We The People API of the Whitehouse.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
		
		present(ac, animated: true)
	}
	
	func showError() {
		let ac = UIAlertController(title: "Loading Error",
								   message: "There was a problem loading the feed; please check your connection and try again.",
								   preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		
		present(ac, animated: true)
	}
	
	func parse(json: Data) {
		let decoder = JSONDecoder()
		
		if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
			petitions = jsonPetitions.results
			tableView.reloadData()
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = petitions[indexPath.row]
		cell.textLabel?.text = petition.title
		cell.detailTextLabel?.text = petition.body
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.detailItem = petitions[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}

}

