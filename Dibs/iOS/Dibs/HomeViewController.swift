//
//  HomeViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/27/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
//    fileprivate let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 20.0
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
////        cv.register(SpotCell.self, forCellWithReuseIdentifier: "spotCell")
//        cv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
//        return cv
    //    }()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let refreshControl = UIRefreshControl()
    
//    fileprivate let bannerView: UIView = {
//        let bannerView = UIView(frame: .zero)
//        return bannerView
//    }()
    @IBOutlet weak var bannerView: UIView!
    
    fileprivate let colors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.green, UIColor.red, UIColor.green, UIColor.red, UIColor.green]
    
    fileprivate var spotCounts = ["10", "20", "30", "10", "20", "30", "10", "20", "30"]
    
    fileprivate var spotTags = ["Klaus", "Van Leer", "McCamish Pavilion", "Green", "Red", "Green", "Red", "Green"]
    
    fileprivate var spotCount: Int = 0

//    @IBOutlet weak var scrollView: UIScrollView!
    
//    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: collectionView.frame.width/2.0, height: collectionView.frame.height/1.5)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 100, right: 10)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
//        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        
            
        // Do any additional setup after loading the view.
        
        // get data of how many Spots from spot class
        spotCount = 7
        
//        collectionView.reloadData()
        
    }
    
    @objc
    private func didPullToRefresh(_ sender:Any) {
        print("Refresh Data")
        
        let db = FireDatabaseController(ref: Database.database().reference())
        let dibsChairList = db.readAllChairs()
        print(dibsChairList)
        for chair in dibsChairList {
            print(chair)
        }
        
        refreshControl.endRefreshing()
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




extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 0.95*collectionView.frame.width
        return CGSize(width: collectionView.frame.width/2.0 - 15.0, height: collectionView.frame.width/2.0 - 15.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotCount
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Starting Index: \(sourceIndexPath.item)")
        print("Ending Index: \(destinationIndexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dibsCell", for: indexPath) as! DibsCell
        print(cell)
        if let label = cell.locationLabel {
            label.text = spotTags[indexPath.row]
        }
        if let countLabel = cell.spotCountLabel {
            countLabel.text = spotCounts[indexPath.row]
        }
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.contentOffset.x = 0.0
//    }
    
}

extension HomeViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnter session: UIDropSession) {
        print("Enter")
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidExit session: UIDropSession) {
        print("Exit")
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let tag = spotTags[indexPath.row]
        let count = spotCounts[indexPath.row]
        let arr = [tag, count]
        let itemProvider = NSItemProvider(object: tag as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = arr
        print("Touched \(tag)")
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("Drop Delegate Method")
        var destinationPathIndex: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationPathIndex = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationPathIndex = IndexPath(item: row - 1, section: 0)
        }
        if coordinator.proposal.operation == .move {
            print("Here")
            self.reorderItems(collectionView: collectionView, coordinator: coordinator, destinationIndexPath: destinationPathIndex)
        }
    
    }
    
    fileprivate func reorderItems(collectionView: UICollectionView, coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath) {
        if let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath {
            
            collectionView.performBatchUpdates({
                
                if let arr = item.dragItem.localObject as? [NSString] {
                    self.spotTags.remove(at: sourceIndexPath.item)
                    self.spotTags.insert(arr[0] as String, at: destinationIndexPath.item)
                    self.spotCounts.remove(at: sourceIndexPath.item)
                    self.spotCounts.insert(arr[1] as String, at: destinationIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }
                
            }, completion: nil)
            
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
}
