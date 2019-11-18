//
//  ViewController.swift
//  Project4
//
//  Created by Henry, Noah on 11/15/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
	var websites = ["apple.com", "hackingwithswift.com", "angular.io"]

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Web Pages"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return websites.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Website")
		let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
		cell.textLabel?.text = websites[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "WebBrowser") as? BrowserViewController else {
            fatalError("Unable to instantiate WebViewController")
        }
		vc.websites = websites
		vc.selectedWebsite = indexPath.row
		navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
