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
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
		
		// Provide Navigation with a title.
		title = "\(imageName!)'s flag"
		
		// Since the selectedImage may or may not exist, we need to make sure it is there before setting it.
		if let imageToLoad = selectedImage {
			print("imageToLoad: \(imageToLoad)")
			imageView.image = UIImage(named: imageToLoad)
		}
    }
	
//	@objc func shareTapped() {
//		guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
//			print("No image found.")
//			return
//		}
//
//		// print("The selected image: \(selectedImage!)")
//
//		let vc = UIActivityViewController(activityItems: [image, selectedImage!], applicationActivities: [])
//		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//		present(vc, animated: true)
//	}
	
	@objc func shareTapped() {
		guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
			print("No image found.")
			return
		}
		
		let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
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
