//
//  HomeViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/27/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SpotCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    fileprivate let colors = [UIColor.green, UIColor.yellow, UIColor.red]
    fileprivate var spotTags = ["Green", "Yellow", "Red"]
    
    fileprivate var spotCount: Int = 0

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
//        let navigationItem = UINavigationItem(title: "Your Dibs")
//        navigationBar.setItems([navigationItem], animated: false)
//        view.addSubview(navigationBar)
        
        contentView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        
        collectionView.reloadData()
        
        
        // Do any additional setup after loading the view.
        
        // get data of how many Spots from spot class
        spotCount = 3
        
        
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/2.0)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpotCell
        cell.occupancyView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
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
        let itemProvider = NSItemProvider(object: tag as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = tag
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
                self.spotTags.remove(at: sourceIndexPath.item)
                self.spotTags.insert(item.dragItem.localObject as! String, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: nil)
            
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
}



class SpotCell: UICollectionViewCell {
    
    fileprivate let occupancyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height/8.0
        contentView.addSubview(occupancyView)
        occupancyView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        occupancyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        occupancyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        occupancyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3*contentView.frame.width/4).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
