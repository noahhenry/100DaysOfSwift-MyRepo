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
	var petitionsBackup = [Petition]()
	var filteredPetitions = [Petition]()
	var filterMode: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Filter List Alert
		let filterButton: UIBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterAlert))
		// self.navigationItem.leftBarButtonItem = filterButton
		
		// Reset Button
		let resetButton: UIBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
		// self.navigationItem.barb
		self.navigationItem.leftBarButtonItems = [filterButton, resetButton]
		
		// Credits Alert
		let creditsButton: UIBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
		self.navigationItem.rightBarButtonItem = creditsButton
		
		// Seting Up The URL & Parsing of Data
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
		
		// Runs if no data returned
		showError()
	}
	
	@objc func filterAlert() {
		let ac = UIAlertController(title: "Filter Results", message: nil, preferredStyle: .alert)
		ac.addTextField(configurationHandler: { (textField) in
			textField.placeholder = "2nd Amendment"
		})
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		ac.addAction(UIAlertAction(title: "Filter", style: .default, handler: { (UIAlertAction) in
			// Do the filtering here?
			print("Filtering...")
			
			guard let term = ac.textFields?[0].text else { return }
			self.filterPetitions(term)
		}))
		
		present(ac, animated: true)
	}
	
	@objc func reset() {
		filterMode = false
		petitions = petitionsBackup
		tableView.reloadData()
	}
	
	@objc func showCredits() {
		let ac = UIAlertController(title: "Data Source", message: "The data used in this app is sourced from the We The People API of the Whitehouse.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
		
		present(ac, animated: true)
	}
	
	func filterPetitions(_ term: String) {
		let lowerTerm = term.lowercased()
		
		filterMode = true
		filteredPetitions = []
		
		if !lowerTerm.isEmpty {
			print("We have a filter term and it is: \(lowerTerm)")
			
			// Check the petitions array and see if either the title or body contain the term passed and add that petition to the filteredPartitions array.
			for petition in petitions {
				var doesContain: Bool = false
				let lowerTitle = petition.title.lowercased()
				let lowerBody = petition.body.lowercased()
				
				if lowerTitle.localizedStandardContains(lowerTerm) {
					print("Has term in title")
					doesContain = true
				} else if lowerBody.localizedStandardContains(lowerTerm) {
					print("Has term in body")
					doesContain = true
				}
				
				print("-------------------------")
				if doesContain == true {
					filteredPetitions.append(petition)
					print(filteredPetitions)
				}
			}
			
			if !filteredPetitions.isEmpty {
				print("Reload view with filteredPetitions list.")
				petitions = filteredPetitions
				tableView.reloadData()
			} else {
				let ac = UIAlertController(title: "No Results", message: "We could not find a pitition that contained the use of \"\(term)\".", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
				
				present(ac, animated: true)
			}
		}
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
			petitionsBackup = petitions
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

