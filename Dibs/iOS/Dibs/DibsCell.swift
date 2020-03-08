//
//  DibsCell.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/7/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class DibsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var occupancyView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var openSpotCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    func sharedInit() {
        self.backgroundView?.clipsToBounds = true
        self.contentView.clipsToBounds = true
        let cornerRadius = self.contentView.frame.size.height/7.0
        
        self.backgroundView?.layer.cornerRadius = cornerRadius
        self.contentView.layer.cornerRadius = cornerRadius
        
        print("AHHH")
    }
    
}
