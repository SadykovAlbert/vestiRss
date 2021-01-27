//
//  CollectionViewController.swift
//  rss
//
//  Created by Albert on 26.01.2021.
//  Copyright © 2021 Albert. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    
    
    let itemsPerRow:CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    
    let photosNames = ["Вести","Lenta","Meduza","Дождь","РБК"]
    let urlsNames = ["https://www.vesti.ru/vesti.rss",
                     "https://lenta.ru/rss",
                     "https://meduza.io/rss2/all",
                     "https://tvrain.ru/export/rss/all.xml",
                     "http://static.feed.rbc.ru/rbc/logical/footer/news.rss"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
    
        //cell.backgroundColor = .blue
        
        let imageName = photosNames[indexPath.item]
        let image = UIImage(named: imageName)
        cell.imageView.image = image
        cell.url = urlsNames[indexPath.item]
        cell.name = imageName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showDetailSegue" else {return}
        
        let cell = sender as! CollectionViewCell
        let detailVC = segue.destination as! FeedListViewController
        //detailVC.image = cell.imageView.image
        
        let url = URL(string: cell.url)
        detailVC.url = url
        detailVC.nameOfSource = cell.name
    }

    
}

extension CollectionViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthOfItemsPerRow = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - widthOfItemsPerRow
        let width = availableWidth / itemsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts//UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}
