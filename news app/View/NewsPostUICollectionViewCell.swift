//
//  NewsPostUICollectionViewCell.swift
//  news app
//
//  Created by Naman Jain on 08/09/21.
//

import UIKit

class NewsPostUICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shortTitle: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsDescription.setLineSpacing(lineSpacing: 1.2, lineHeightMultiple: 1.2)
    }
    
    func configureCell(
        shortTitle: String,
        newsTitle: String,
        newsDescription: String,
        newsImage: UIImage
    ){
        self.shortTitle.text = shortTitle
        self.newsTitle.text = newsTitle
        self.newsDescription.text = newsDescription
        self.newsImage.image = newsImage
    }
    
    
    
    @IBAction func readMoreButtonTapped(_ sender: UIButton) {
//        guard let url = URL(string: getNewsUrl()) else {
//            return
//        }
//
//        let vc = WebViewController(url: url,title: "google")
//        let navVc = UINavigationController(rootViewController: vc)
//
        print("read more button tapped")
    }
    
    private func getNewsUrl()->String{
        return "https://google.com"
    }
}
