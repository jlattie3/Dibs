//
//  HomeViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/27/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var bannerView: UIView!
    
    fileprivate let colors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.green, UIColor.red, UIColor.green, UIColor.red, UIColor.green]
    
    fileprivate var spotCounts = ["0", "20", "30", "10", "20", "30", "10", "20", "30"]
    
    var spotTags: [String] = []
    var buildingNames: [NSManagedObject] = []
    
    fileprivate var spotCountDict = Dictionary<String, Int>()
    var thisDibsChairList: [DibsChair] = []
    
//    fileprivate var spotCount: Int = 0

//    @IBOutlet weak var scrollView: UIScrollView!
    
//    @IBOutlet weak var contentView: UIView!
    
    let db = Database.database().reference()
    typealias FirebaseClosure = (Dictionary<String, Int>?) -> Void
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        readUserDefaults()
        readAllChairs() { dict in
            print("Closure???")
            if dict == nil {
                print("nil")
                return
            }
            print(dict)
            if let thisDict = dict {
                self.spotCountDict = thisDict
            }
            
        }
        print(self.spotCounts)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        readUserPref()
//        readAllChairs()
        print("HERE ------------")
        print(self.spotTags)
        print(self.spotCountDict)
//        self.spotTags = ["CULC", "Klaus", "Van Leer", "Howey", "Student Center"]
        
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
        
            
        // Do any additional setup after loading the view
//        collectionView.refreshControl?.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40).isActive = true
        collectionView.refreshControl?.translatesAutoresizingMaskIntoConstraints = false
        // get data of how many Spots from spot class (tester + db.count + add_new_cell)
//        self.spotCount = 1 + self.spotDict.count + 1
        
//        collectionView.reloadData()
        print("Debug")
        print(self.spotTags)
    }
    
    func readUserDefaults() {
        let userDefaults = UserDefaults.standard
        if let tagDict = userDefaults.object(forKey: "dibsSpotDict") as? Dictionary<String, Int>{
            self.spotTags = Array(repeating: " ", count: tagDict.count)
            for (key, val) in tagDict {
                self.spotTags[val] = key
            }
        }
    }
    
    func storeUserDefaults() {
        let userDefaults = UserDefaults.standard
        var storeDict: Dictionary<String, Int> = [:]
        for (i, tag) in self.spotTags.enumerated() {
            storeDict[tag] = i
        }
        userDefaults.set(storeDict, forKey: "dibsSpotDict")
    }
    
    func readAllChairs(completionHandler:@escaping FirebaseClosure) {
        self.db.child("chair").observe(.value, with: { (snapshot) in
            // Get chair data
            guard let value = snapshot.value as? NSDictionary else {
                print("Invalid Firebase Read")
                return
            }
            var dibsChairList = [DibsChair]()
            print(".")
            print(".")
            print(".")
            let keys = value.allKeys
            print("Keys: ")
            print(keys)
            
            for key in keys {
                
                let dibsChair = DibsChair()
                
                if let chair_dict = value[key] as? NSDictionary {
                    
                    print("------")
                    
                    if let building = chair_dict["Building"] as? String {
                        print(building)
                        dibsChair.building = building
                    }
                    if let floor = chair_dict["Floor"] as? String {
                        print(floor)
                        dibsChair.floor = floor
                    }
                    if let room = chair_dict["Room"] as? String {
                        print(room)
                        dibsChair.room = room
                    }
                    if let status = chair_dict["status"] as? String {
                        print(status)
                        dibsChair.status = status
                    }
                    dibsChairList.append(dibsChair)
                    print("------")
                } else {
                    continue
                }
                
            }
            self.thisDibsChairList = dibsChairList
            self.spotCountDict = self.getDictOfDibsBuildings()
            
            print(".")
            print(".")
            print(".")
            
//            if dibsChairList.isEmpty {
//                print("No change in data")
//            } else {
//                self.collectionView.reloadData()
//            }
            DispatchQueue.main.async() {
                if self.spotCountDict.isEmpty {
                    completionHandler(nil)
                } else {
                    completionHandler(self.spotCountDict)
                }
                self.collectionView.reloadData()
            }
            
        }) { (error) in
            print("readAllChairs error")
            print(error.localizedDescription)
        }
        print("No Firebase Exec")
    }
    
//    func completionHandler(dict: Dictionary<String, Int>) {
//        print("Firebase Read Complete")
//        self.collectionView.reloadData()
//    }
        
    func getDictOfDibsBuildings() -> Dictionary<String, Int> {
        
        print("Building Dict")
        var buildingDict = Dictionary<String, Int>()
        
        for chair in self.thisDibsChairList {
            if chair.status == "0" {
                buildingDict[chair.building, default: 0] += 1
            }
        }
        print(buildingDict)
        return buildingDict
    }
    
    func pushCellToFront(sourceIndex: Int) {
        print(sourceIndex)
        let itemToInsert = self.spotTags[sourceIndex] as String
        self.spotTags.remove(at: sourceIndex)
        self.spotTags.insert(itemToInsert, at: 0)

        self.collectionView.deleteItems(at: [IndexPath(row: sourceIndex, section: 0)])
        self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
        
        self.storeUserDefaults()
    }
    
    func pushCellToBack() {
        
    }
    
    @objc
    private func didPullToRefresh(_ sender:Any) {
        print("Refresh Data")
        readAllChairs() { dict in
            print("Closure???")
            if dict == nil {
                print("nil")
                return
            }
            if let thisDict = dict {
                print(thisDict)
                self.spotCountDict = thisDict
            }
        }
        refreshControl.endRefreshing()
    }
    
    func mapCallback() {
        print("Mapp Add Callback")
        self.readUserDefaults()
        self.collectionView.reloadData()
    }
    
    func getCoordOfForLocationButton(locationName: String) -> CLLocationCoordinate2D {
        let GeorgiaTechCoord = CLLocationCoordinate2DMake(33.776575, -84.398287)
        let CulcCoord = CLLocationCoordinate2DMake(33.774621, -84.396367)
        let VanLeerCoord = CLLocationCoordinate2DMake(33.775964, -84.397134)
        let KlausCoord = CLLocationCoordinate2DMake(33.777168, -84.396211)
        let HoweyCoord = CLLocationCoordinate2DMake(33.77744, -84.398678)
        let StudentCenterCoord = CLLocationCoordinate2DMake(33.774149, -84.398818)
        let BoggsCoord = CLLocationCoordinate2DMake(33.775656, -84.399821)
        
        switch locationName {
        case "CULC":
            return CulcCoord
        case "Van Leer":
            return VanLeerCoord
        case "Klaus":
            return KlausCoord
        case "Howey":
            return HoweyCoord
        case "Student Center":
            return StudentCenterCoord
        case "Boggs":
            return BoggsCoord
        default:
            return GeorgiaTechCoord
        }
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



// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 0.95*collectionView.frame.width
        return CGSize(width: collectionView.frame.width/2.0 - 15.0, height: collectionView.frame.width/2.0 - 15.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spotTags.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row == self.spotTags.count {
            print("nope")
            return false
        }
        return true
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("Row: \(indexPath.row)")
        if (indexPath.row == self.spotTags.count) {
            print("Add Cell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addDibsCell", for: indexPath) as! AddDibsCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dibsCell", for: indexPath) as! DibsCell
        print(cell)
        
        cell.deleteTapped = { () in
            if let str = cell.locationLabel.text {
                if let ind = self.spotTags.firstIndex(of: str) {
                    print("Delete Tapped \(str)")
                    print(self.collectionView.numberOfItems(inSection: 0))
                    print(indexPath)
                    print(ind)
                    print(self.spotTags)
                    self.spotTags.remove(at: ind)
                    self.collectionView.deleteItems(at: [IndexPath(item: ind, section: 0)])
                }
            }
            self.storeUserDefaults()
            return
        }
        
        cell.favoriteTapped = { () in
            if let favButton = cell.favoriteButton {
                let newStatus = !cell.favoriteStatus
                if (newStatus) {
                    favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    if let str = cell.locationLabel.text {
                        if let ind = self.spotTags.firstIndex(of: str) {
                            self.pushCellToFront(sourceIndex: ind)
                        }
                    }
                } else {
                    favButton.setImage(UIImage(systemName: "star"), for: .normal)
                    self.pushCellToBack()
                }
                favButton.imageView?.tintColor = .systemYellow
                cell.favoriteStatus = newStatus
                self.collectionView.reloadData()
            }
            return
        }
        
        cell.notificationTapped = { () in
            if let notifButton = cell.notificationButton {
                let newStatus = !cell.notifStatus
                if (newStatus) {
                    notifButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
                    if let str = cell.locationLabel.text {
                        let alert = UIAlertController(title: "Call Dibs", message: "Would you like to receive open spot notifications for \(str)?", preferredStyle: UIAlertController.Style.alert)
                        // add the actions (buttons)
                        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) in
                            cell.notifStatus = newStatus
                        }))
                        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert: UIAlertAction!) in
                            notifButton.setImage(UIImage(systemName: "bell"), for: .normal)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    notifButton.setImage(UIImage(systemName: "bell"), for: .normal)
                    cell.notifStatus = newStatus
                }
//                notifButton.imageView?.tintColor = .
//                self.collectionView.reloadData()
            }
            return
        }
        
        cell.locationTapped = { () in
            if let str = cell.locationLabel.text {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let dibsMapViewController = storyBoard.instantiateViewController(withIdentifier: "dibsMapViewController") as! DibsMapViewController
                dibsMapViewController.spotTags = self.spotTags
                dibsMapViewController.initCoord = self.getCoordOfForLocationButton(locationName: str)
                dibsMapViewController.homeViewController = self
                self.present(dibsMapViewController, animated:true, completion:nil)
            }
        }
        
        
        if let label = cell.locationLabel {
            label.text = self.spotTags[indexPath.row]
        }
        if let countLabel = cell.spotCountLabel {
//            countLabel.text = self.spotCounts[indexPath.row]
            countLabel.text = "--"
            for (key, val) in self.spotCountDict {
                if key == self.spotTags[indexPath.row] {
                    countLabel.text = String(val)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dibsCell", for: indexPath) as! DibsCell
        if (indexPath.row == self.spotTags.count) {
            print("Add Cell Tapped")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let dibsMapViewController = storyBoard.instantiateViewController(withIdentifier: "dibsMapViewController") as! DibsMapViewController
            dibsMapViewController.spotTags = self.spotTags
            self.present(dibsMapViewController, animated:true, completion:nil)
            dibsMapViewController.homeViewController = self
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let dibsSpotViewController = storyBoard.instantiateViewController(withIdentifier: "dibsSpotViewController") as! DibsSpotViewController
            dibsSpotViewController.spotName = self.spotTags[indexPath.row]
            self.present(dibsSpotViewController, animated:true, completion:nil)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.contentOffset.x = 0.0
//    }
    
}

// MARK: - UICollectionViewDragDelegate, UICollectionViewDropDelegate
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
            if let indexPath = destinationIndexPath {
                if indexPath.row != self.spotTags.count {
                    return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                }
            }
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        var tag = " "
        var count = " "
        if indexPath.row < self.spotTags.count {
            tag = spotTags[indexPath.row]
            count = spotCounts[indexPath.row]
        }
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
//                    self.spotCounts.remove(at: sourceIndexPath.item)
//                    self.spotCounts.insert(arr[1] as String, at: destinationIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                    
                    self.storeUserDefaults()
                }
                
            }, completion: nil)
            
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
//            self.collectionView.reloadData()
        }
    }
    
}
