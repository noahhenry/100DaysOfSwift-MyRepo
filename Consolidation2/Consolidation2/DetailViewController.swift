//
//  DetailViewController.swift
//  Consolidation2
//
//  Created by Henry, Noah on 10/15/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?
	var imageName: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		// Provide Navigation with a title.
		title = "\(imageName!)'s flag"
		
		// Since the selectedImage may or may not exist, we need to make sure it is there before setting it.
		if let imageToLoad = selectedImage {
			print("imageToLoad: \(imageToLoad)")
			imageView.image = UIImage(named: imageToLoad)
		}
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
