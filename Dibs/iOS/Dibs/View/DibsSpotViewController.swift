//
//  DibsSpotViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/30/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import Charts

class DibsSpotViewController: UIViewController {
    
    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var buildingNameLabel: UILabel!
    
    
    @IBOutlet weak var spotCountView: UIView!
    @IBOutlet weak var floorPlanView: UIView!
    @IBOutlet weak var floorSelectionView: UIView!
    @IBOutlet weak var floorView: UIView!
    var floorScrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedFloorNum: Int = 0
    
    @IBOutlet weak var popularTimeView: UIView!
    @IBOutlet weak var barChartView: BarChartView!
    
    fileprivate let timeOfDay = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
    
    fileprivate let floorNumbers = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarChart()
        
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        // handleView rounded corners
        self.handleView.layer.cornerRadius = self.handleView.frame.height / 3.0
        
        // shadow UI
        let spotCornerRadius = self.spotCountView.frame.height / 15.0
        // shadow spotCountView
        self.spotCountView.layer.cornerRadius = spotCornerRadius
        self.spotCountView.clipsToBounds = true
        self.spotCountView.layer.shadowColor = UIColor.gray.cgColor
        self.spotCountView.layer.shadowOpacity = 0.5
        self.spotCountView.layer.shadowOffset = CGSize.zero
        self.spotCountView.layer.shadowRadius = 5.0
        self.spotCountView.layer.masksToBounds = false
        // shadow popularTimesView
        self.popularTimeView.layer.cornerRadius = spotCornerRadius
        self.popularTimeView.clipsToBounds = true
        self.popularTimeView.layer.shadowColor = UIColor.gray.cgColor
        self.popularTimeView.layer.shadowOpacity = 0.5
        self.popularTimeView.layer.shadowOffset = CGSize.zero
        self.popularTimeView.layer.shadowRadius = 5.0
        self.popularTimeView.layer.masksToBounds = false
        // shadow floorPlanView
        self.floorPlanView.layer.cornerRadius = spotCornerRadius
        self.floorPlanView.clipsToBounds = true
        self.floorPlanView.layer.shadowColor = UIColor.gray.cgColor
        self.floorPlanView.layer.shadowOpacity = 0.5
        self.floorPlanView.layer.shadowOffset = CGSize.zero
        self.floorPlanView.layer.shadowRadius = 5.0
        self.floorPlanView.layer.masksToBounds = false
        // floorSelection scrolling
        
        self.floorScrollView = UIScrollView(frame: self.floorView.bounds)
        self.floorScrollView.backgroundColor = UIColor.white
        self.floorScrollView.contentSize = self.floorView.bounds.size
        self.floorScrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        self.floorView.addSubview(self.floorScrollView)
        
        self.floorScrollView.delegate = self
        self.floorScrollView.minimumZoomScale = 0.7
        self.floorScrollView.maximumZoomScale = 3.0
        self.floorScrollView.zoomScale = 0.7
        drawCulcBase()
        
        
        // building Name
        self.buildingNameLabel.text = "Klaus Advanced Computing Building"
        
        
    }
    
    func setBarChart() {
        //future home of bar chart code
        var entryArr: [BarChartDataEntry] = [BarChartDataEntry]()
                
        // x Axis UI
        let xAxis = self.barChartView.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.axisMinimum = 0.0
//        xAxis.valueFormatter = axisFormatDelegate
        self.barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: {(index, _) in
            return self.timeOfDay[Int(index)]
        })
        
        // y Axis UI
        let yAxisRight = self.barChartView.rightAxis
        yAxisRight.enabled = false
        let yAxisLeft = self.barChartView.leftAxis
//        yAxisLeft.enabled = false
        yAxisLeft.axisLineColor = UIColor.clear
        yAxisLeft.axisMinimum = 0.0
        yAxisLeft.axisMaximum = 100.0
        
        // build Test data
        for i in 0...23 {
            let entry: BarChartDataEntry = BarChartDataEntry(x: Double(i), y: Double(Int.random(in: 1..<100)))
            entryArr.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entryArr, label: nil)
        dataSet.drawValuesEnabled = false
        dataSet.colors = [#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)]
        let data = BarChartData(dataSets: [dataSet])
        self.barChartView.data = data
        
        //All other additions to this function will go here
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            let hour = Calendar.current.component(.hour, from: Date())
            self.barChartView.moveViewToX(Double(hour - 3))
        }
        
        self.barChartView.setVisibleXRangeMaximum(7)
        self.barChartView.legend.enabled = false
        self.barChartView.highlightPerTapEnabled = false
        self.barChartView.doubleTapToZoomEnabled = false
        self.barChartView.pinchZoomEnabled = false

        //This must stay at end of function
        self.barChartView.setNeedsDisplay()
        self.barChartView.notifyDataSetChanged()
    }
    
    func drawCulcBase() {
        let culcBase = CAShapeLayer()
        self.floorScrollView.layer.addSublayer(culcBase)
        
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
        let width = self.floorView.frame.width
        
        let culcWidth: CGFloat = width * 5/6
        let culcHeight: CGFloat = width * 5/6 * 2

        let xOffset: CGFloat = width/2 - culcWidth/2
        let yOffset: CGFloat = width/2 - culcWidth/2
        
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
        let width = self.floorView.frame.width
        
        let culcWidth: CGFloat = width * 5/6
        let culcHeight: CGFloat = width * 5/6 * 2

        let xOffset: CGFloat = width/2 - culcWidth/2
        let yOffset: CGFloat = width/2 - culcWidth/2
        
        // room152
        let room152 = CAShapeLayer()
        self.floorScrollView.layer.addSublayer(room152)
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
        self.floorScrollView.layer.addSublayer(room144)
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

extension DibsSpotViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return floorView
    }
    
}

extension DibsSpotViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "floorCell", for: indexPath) as! FloorCell
        cell.floorNumLabel.text = floorNumbers[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        self.selectedFloorNum = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "floorCell", for: indexPath) as! FloorCell
        cell.floorNumLabel.text = " "
        cell.floorNumLabel.textColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    }
    
}
