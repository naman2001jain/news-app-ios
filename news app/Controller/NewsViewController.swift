//
//  NewsViewController.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var shorthandLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

   
    @IBAction func readMoreButtonTapped(_ sender: UIButton) {
        print("button pressed")
    }
    
}
