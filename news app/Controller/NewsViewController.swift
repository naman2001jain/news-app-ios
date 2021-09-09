//
//  NewsViewController.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NewsPostUICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsPost")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        collectionView.isPagingEnabled = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    private func fetchNewsDetails(){
        ApiCallers.shared.getTopHeadlines { (res) in
            
            switch res{
            case .success(let model):
                print("success")
                print(model.totalResults)
                break
                
            case .failure(let err):
                self.failedToFetchNewsDetails()
                print(err.localizedDescription)
            }
            
        }
        
    }
    
    func failedToFetchNewsDetails(){
        print("error to fetch news details")
    }
    
    
}

extension NewsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPost", for: indexPath) as! NewsPostUICollectionViewCell
        cell.configureCell(shortTitle: "this is a short title", newsTitle: "One day, covid-19 will be knows as maharastra corona", newsDescription: "this is a description. and here a long paragraph will comethis is a description. and here a long paragraph will comethis is a description. and here a long paragraph will comethis is a description. and here a long paragraph will comethis is a description. and here a long paragraph will comethis is a description. and here a long paragraph will comethis is a description. and here a long paragraph will comethis is a description. and here a long paragraph will come", newsImage: UIImage(named: "pic")!)
        return cell
    }
}


extension NewsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
   
}
