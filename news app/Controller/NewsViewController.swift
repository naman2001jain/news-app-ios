//
//  NewsViewController.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, UICollectionViewDelegate, NewsPostCollectionViewCellDelegate {
    
    @IBAction func refreshBarButtonPressed(_ sender: UIBarButtonItem) {
        self.handleRefreshing()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func didPressedReadMoreButton() {
        if let url = newsPostUrl{
            let webVc = WebViewController(url: url, title: "Read More")
            let navVc = UINavigationController(rootViewController: webVc)
            present(navVc, animated: true, completion: nil)
        }
    }
    
    
    //some variables
    var newsPostUrl: URL?
    
    var response: ApiResponse!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionView: UICollectionView!
    
    //floating button
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        //appearance
        button.tintColor = .link
        button.backgroundColor = .label
        let image = UIImage(systemName: "arrow.up",withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .medium))
        button.setImage(image, for: .normal)
        //corner radius
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NewsPostUICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsPost")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchNewsDetails()
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(handleRefreshing), for: .valueChanged)
        //adding the floating view to the view
        view.addSubview(floatingButton)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: (view.frame.size.width - 60)/2,
                                      y: view.frame.size.height - 60*2 - view.safeAreaInsets.bottom, width: 60, height: 60)
    }
    
    @objc func arrowButtonTapped(){
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
     private func fetchNewsDetails(){
        ApiCallers.shared.getTopHeadlines { (res) in
            DispatchQueue.main.async {
                switch res{
                case .success(let model):
                    self.updateUI(with : model)
                    self.refreshControl.endRefreshing()
                    
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
    
    @objc private func handleRefreshing(){
        fetchNewsDetails()
        
    }
    
    
}

extension NewsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response?.totalResults ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 19{
            print("refresh needed")
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPost", for: indexPath) as! NewsPostUICollectionViewCell
        cell.newsPostCellDelegate = self
        let article = response?.articles[indexPath.row]
        DispatchQueue.main.async {
            cell.configureCell(shortTitle: (article?.title) ??  "News Title", newsTitle:  (article?.title) ?? "News Title", newsDescription: (article?.content) ??  "No Description Available... swipe left to see full details.", newsImage: (article?.urlToImage) ?? "")
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells{
            let currentCellIndexPath = collectionView.indexPath(for: cell)
            let urlString = response.articles[currentCellIndexPath!.row].url
            newsPostUrl = URL(string: urlString ?? "")
        }
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
