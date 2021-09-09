//
//  NewsViewController.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, UICollectionViewDelegate {
    
    //some variables
    var response: ApiResponse!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NewsPostUICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsPost")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchNewsDetails()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private func fetchNewsDetails(){
        ApiCallers.shared.getTopHeadlines { (res) in
            DispatchQueue.main.async {
                switch res{
                case .success(let model):
                    self.updateUI(with : model)
                    
                    print("success")
                    break
                    
                case .failure(let err):
                    self.failedToFetchNewsDetails()
                    print(err.localizedDescription)
                }
            }
            
            
        }
        
    }
    
    private func updateUI(with model: ApiResponse){
        response = model
        collectionView.reloadData()
    }
    
    func failedToFetchNewsDetails(){
        print("error to fetch news details")
    }
    
    
}

extension NewsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response?.totalResults ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPost", for: indexPath) as! NewsPostUICollectionViewCell
        let article = response?.articles[indexPath.row]
        
        cell.configureCell(shortTitle: (article?.title) ??  "title", newsTitle:  (article?.title) ?? "title", newsDescription: (article?.content) ??  "news description", newsImage: UIImage(named: "pic")!)
        
        
        
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
