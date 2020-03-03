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
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SpotCell.self, forCellWithReuseIdentifier: "cell")
        cv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Dibs"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
//    fileprivate let bannerView: UIView = {
//        let bannerView = UIView(frame: .zero)
//        return bannerView
//    }()
    @IBOutlet weak var bannerView: UIView!
    
    fileprivate let colors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.green, UIColor.red, UIColor.green, UIColor.red, UIColor.green]
    
    fileprivate var spotTags = ["Green", "Yellow", "Red", "Green", "Red", "Green", "Red", "Green"]
    
    fileprivate var spotCount: Int = 0

//    @IBOutlet weak var scrollView: UIScrollView!
    
//    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SpotCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.register(UINib(nibName: "SpotCell.xib", bundle: nil), forCellWithReuseIdentifier: "cell")
        
//        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
//        let navigationItem = UINavigationItem(title: "Your Dibs")
//        navigationBar.setItems([navigationItem], animated: false)
//        view.addSubview(navigationBar)
//        print(scrollView.frame.size.width)
//        print(view.frame.size.width)
//        print(contentView.frame.size.width)
//        scrollView.contentSize = CGSize(width: 1000, height: 2000)
        
        view.addSubview(collectionView)
        let topConstant = CGFloat(view.frame.size.height/6)
        collectionView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
//        view.addSubview(bannerView)
//        bannerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//        bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
//        bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        bannerView.backgroundColor = .red
        bannerView.addSubview(titleLabel)
//        titleLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 10).isActive = true
        
        
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        
//        collectionView.reloadData()
        
        
        // Do any additional setup after loading the view.
        
        // get data of how many Spots from spot class
        spotCount = 8
        
        
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
        let cell: SpotCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpotCell
        cell.occupancyView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
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



//class SpotCell: UICollectionViewCell {
//
//    fileprivate let occupancyView: UIView = {
//        let view = UIView(frame: .zero)
////        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true
//        return view
//    }()
//
//    fileprivate let label: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "20/30"
//        label.font = .systemFont(ofSize: 20)
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        contentView.backgroundColor = .blue
//        contentView.clipsToBounds = true
//        contentView.layer.cornerRadius = contentView.frame.height/8.0
//
//        contentView.addSubview(occupancyView)
//        occupancyView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        occupancyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        occupancyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        occupancyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3*contentView.frame.width/4).isActive = true
//
//        occupancyView.addSubview(label)
//        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        label.centerYAnchor.constraint(equalTo: occupancyView.centerYAnchor).isActive = true
////        contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ).isActive = true
////        label.centerXAnchor.constraint(equalTo: occupancyView.centerXAnchor, constant: occupancyView.frame.width/2).isActive = true
////        contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3*contentView.frame.width/4).isActive = true
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
