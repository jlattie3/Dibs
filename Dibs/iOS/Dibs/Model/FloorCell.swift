//
//  FloorCollectionViewCell.swift
//  Dibs
//
//  Created by Jacob Lattie on 4/6/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class FloorCell: UICollectionViewCell {
    
    @IBOutlet weak var floorNumLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override var isSelected: Bool {
        didSet {
            self.floorNumLabel.textColor = isSelected ? #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1) : UIColor.darkGray
        }
    }
    
    func sharedInit() {

        self.contentView.clipsToBounds = true
        let cornerRadius = CGFloat(3.0)
        
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
        
    }
}
