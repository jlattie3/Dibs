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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    func sharedInit() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = self.contentView.frame.size.height/8.0
        
        print("AHHH")
    }
    
}
