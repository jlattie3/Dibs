//
//  SpotCell.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/3/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class SpotCell: UICollectionViewCell {
    
    let occupancyView: UIView = {
        let view = UIView(frame: .zero)
//        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20/30"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .blue
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.height/8.0

        contentView.addSubview(occupancyView)
        occupancyView.frame.size.width = contentView.frame.width/4
        occupancyView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        occupancyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        occupancyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        occupancyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3*contentView.frame.width/4).isActive = true

        occupancyView.addSubview(label)
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.centerYAnchor.constraint(equalTo: occupancyView.centerYAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ).isActive = true
        label.centerXAnchor.constraint(equalTo: occupancyView.centerXAnchor).isActive = true
//        contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3*contentView.frame.width/4).isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
