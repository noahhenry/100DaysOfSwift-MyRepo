//
//  ViewController.swift
//  Challenge3
//
//  Created by Henry, Noah on 12/16/19.
//  Copyright © 2019 hackingwithswift. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var shoppingList = [String]()
//	var shoppingList: [String] = ["Milk",
//								  "Salad",
//								  "Carrots",
//								  "Bell Peppers",
//								  "Tooth Paste",
//								  "Peanut Butter",
//								  "Condums",
//								  "Cucumbers",
//								  "Lotion",
//								  "Shampoo",
//								  "Conditonior",
//								  "Tortillas",
//								  "Ground Beef",
//								  "Sage Sausage",
//								  "Light Bulbs",
//								  "A Shovel",
//								  "A Table",
//								  "Cookies",
//								  "Tomato Soup",
//								  "Pancake Mix",
//								  "Blueberry Muffins",
//								  "Funyuns",
//								  "Flaming Hot Popcorn",
//								  "Ketchup",
//								  "Apple Juice"]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		title = "My Shopping List"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	// determine the number of rows in the table
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shoppingList.count
	}
	
	// set the content of the table row cell
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Item")
		let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
		cell.textLabel?.text = shoppingList[indexPath.row]
		return cell
	}
	
	@IBAction func addItem(_ sender: Any) {
		print("Add Item")
		
		let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
			guard let answer = ac.textFields?[0].text else { return }
			self.shoppingList.insert(answer, at: 0)
			
			// used for animation
			let indexPath = IndexPath(row: 0, section: 0)
			self.tableView.insertRows(at: [indexPath], with: .automatic) // .automatic means, do waht is standard for this function
		}))
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		
		present(ac, animated: true)
	}
	
	@IBAction func clearList(_ sender: Any) {
		print("Clear List")
		
		shoppingList.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}
	
}

