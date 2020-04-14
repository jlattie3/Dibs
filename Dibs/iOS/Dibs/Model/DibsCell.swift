//
//  DibsCell.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/7/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class DibsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var spotCountLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    // Callbacks
    var deleteTapped : (()->())?
    var favoriteTapped : (()->())?
    var notificationTapped : (()->())?
    var locationTapped : (()->())?
    
    // class properties
    var favoriteStatus: Bool = false
    var notifStatus: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    func sharedInit() {
        
        
//        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
//        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
//        self.contentView.layer.borderWidth = 1.0
    
//        self.backgroundView?.clipsToBounds = true
        self.contentView.clipsToBounds = true
        let cornerRadius = CGFloat(7.0)
        
        self.backgroundView?.layer.cornerRadius = cornerRadius
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.backgroundColor = UIColor.white.cgColor
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.backgroundColor = UIColor.clear.cgColor
        
        print("AHHH")
        
        setupCellUI()
    }
    
    func setupCellUI() {
        
        // loop over DibsSpots and set UI elements
        
        
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteTapped?()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteTapped?()
    }
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
        notificationTapped?()
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        locationTapped?()
    }
    
    
//    @objc func deleteButtonTapped() {
//        print("Delete DibsSpot")
//        deleteTapped?()
//    }
    
    
}
