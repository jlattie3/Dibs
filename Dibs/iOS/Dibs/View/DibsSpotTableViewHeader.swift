//
//  DibsSpotTableViewHeader.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/30/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class DibsSpotTableViewHeader: UITableViewHeaderFooterView {
    
    
    let title = UILabel()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        configureContents()
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "Clough Undergraduate Learning Commons"
        title.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
//        title.textColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        title.textColor = UIColor.darkGray

        contentView.addSubview(title)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: 0),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

