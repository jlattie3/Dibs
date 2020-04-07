//
//  ScrollFloorPlanViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 4/6/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class ScrollFloorPlanViewController: UIViewController {
    
    var scrollView: UIScrollView!
//    var imageView: UIImageView!
    
    // CULC: H - 6 inch
    // CULC: W - 3 inch
    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
//        imageView = UIImageView(image: UIImage(named: "culc_Floor1.png"))
            
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = view.bounds.size
        scrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)

//        scrollView.addSubview(imageView)
//        let label = UILabel()
//        label.text = "Test"
//        scrollView.addSubview(label)
        view.addSubview(scrollView)
        self.width = view.frame.width
        self.height = view.frame.height
        
        
        drawCulcBase()
        drawCulcRooms()
        
        
    }
    
    func drawCulcBase() {
        let culcBase = CAShapeLayer()
        self.scrollView.layer.addSublayer(culcBase)
        
        culcBase.opacity = 0.5
        culcBase.lineWidth = 1.0
        culcBase.lineJoin = .miter
        culcBase.strokeColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        culcBase.fillColor = UIColor.lightGray.cgColor
        
        // Rectangle bounds, begins from top left corner
//        path.move(to: CGPoint(x: self.width/6, y: 40))
//        path.addLine(to: CGPoint(x: self.width * 5/6, y:40))
//        path.addLine(to: CGPoint(x: self.width * 5/6, y:self.width * 4/6 * 2))
//        path.addLine(to: CGPoint(x: self.width/6, y: self.width * 4/6 * 2))
        
        let path = UIBezierPath()
        // scaled variables
        let culcWidth: CGFloat = self.width * 5/6
        let culcHeight: CGFloat = self.width * 5/6 * 2

        let xOffset: CGFloat = self.width/2 - culcWidth/2
        let yOffset: CGFloat = self.width/2 - culcWidth/2
        
        path.move(to: CGPoint(x: xOffset, y: yOffset))
        path.addLine(to: CGPoint(x: xOffset + 0.2333 * culcWidth, y:yOffset))
        path.addLine(to: CGPoint(x: xOffset + 0.2333 * culcWidth, y:yOffset + 0.1*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + culcWidth, y:yOffset + 0.1*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + culcWidth, y:yOffset + 0.61666*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.78 * culcWidth, y:yOffset + 0.61666*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.78 * culcWidth, y:yOffset + culcHeight))
        path.addLine(to: CGPoint(x: xOffset, y:yOffset + culcHeight))
        
//        path.addLine(to: CGPoint(x: self.width + self.width*0.2333, y:60 + 0.1*self.height))
//        path.addLine(to: CGPoint(x: self.width * 0.8, y:60 + 0.1*self.height))
//        path.addLine(to: CGPoint(x: self.width * 5/6, y:self.width * 4/6 * 2))
//        path.addLine(to: CGPoint(x: self.width/6, y: self.width * 4/6 * 2))
        path.close()
        culcBase.path = path.cgPath
        
        
    }
    
    func drawCulcRooms() {
        
        // scaled variables
        let culcWidth: CGFloat = self.width * 5/6
        let culcHeight: CGFloat = self.width * 5/6 * 2
        
        let xOffset: CGFloat = self.width/2 - culcWidth/2
        let yOffset: CGFloat = self.width/2 - culcWidth/2
        
        // room152
        let room152 = CAShapeLayer()
        self.scrollView.layer.addSublayer(room152)
        room152.opacity = 0.5
        room152.lineWidth = 1.0
        room152.lineJoin = .miter
        room152.strokeColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        room152.fillColor = UIColor.darkGray.cgColor
        var path = UIBezierPath()
        path.move(to: CGPoint(x: xOffset + 0.2316*culcWidth, y: yOffset + 0.1583*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.758*culcWidth, y: yOffset + 0.1583*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.758*culcWidth, y: yOffset + 0.378*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.2316*culcWidth, y: yOffset + 0.378*culcHeight))
        path.close()
        room152.path = path.cgPath
        
        // room144
        let room144 = CAShapeLayer()
        self.scrollView.layer.addSublayer(room144)
        room144.opacity = 0.5
        room144.lineWidth = 1.0
        room144.lineJoin = .miter
        room144.strokeColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        room144.fillColor = UIColor.darkGray.cgColor
        path = UIBezierPath()
        path.move(to: CGPoint(x: xOffset + 0.2316*culcWidth, y: yOffset + 0.384*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.758*culcWidth, y: yOffset + 0.384*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.758*culcWidth, y: yOffset + 0.6166*culcHeight))
        path.addLine(to: CGPoint(x: xOffset + 0.2316*culcWidth, y: yOffset + 0.6166*culcHeight))
        path.close()
        room144.path = path.cgPath
        
        
        
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
