//
//  DetailViewController.swift
//  Project1
//
//  Created by Henry, Noah on 10/10/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?
	
	var selectedImageIndex = 0
	var totalPictures = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Picture \(selectedImageIndex) of \(totalPictures)"
		navigationItem.largeTitleDisplayMode = .never
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
	
	@objc func shareTapped() {
		guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
			print("No image found.")
			return
		}
		
		// print("The selected image: \(selectedImage!)")
		
		let vc = UIActivityViewController(activityItems: [image, selectedImage!], applicationActivities: [])
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
