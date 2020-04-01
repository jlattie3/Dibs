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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buildingLabel: UILabel!
    
    @IBOutlet weak var spotCountView: UIView!
    @IBOutlet weak var floorPlanView: UIView!
    
    @IBOutlet weak var popularTimeView: UIView!
    @IBOutlet weak var barChartView: BarChartView!
    
    fileprivate let timeOfDay = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
    
    fileprivate let sectionHeaderTitles = ["Clough Undergraduate Learning Commons", "Available Seating Space", "Location Information", "Building Floor Plan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.tableView.register(DibsSpotTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
//        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)

        // Do any additional setup after loading the view.
//        self.buildingLabel.text = self.sectionHeaderTitles[0]
        
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
        
//        self.floorPlanView.clipsToBounds = true
////        self.spotCountView.layer.masksToBounds = true
////        self.spotCountView.layer.backgroundColor = UIColor.white.cgColor
////        let spotCornerRadiusFloor = self.floorPlanView.frame.height / 15.0
//        self.spotCountView.layer.masksToBounds = false
//        self.floorPlanView.layer.cornerRadius = spotCornerRadius
//        self.floorPlanView.layer.shadowPath = UIBezierPath(rect: self.floorPlanView.bounds).cgPath
//        self.floorPlanView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
//        self.floorPlanView.layer.shadowColor = UIColor.lightGray.cgColor
//        self.floorPlanView.layer.shadowRadius = 5.0
//        self.floorPlanView.layer.shadowOpacity = 0.5
//        self.floorPlanView.layer.shouldRasterize = true
//        self.floorPlanView.layer.rasterizationScale = true ? UIScreen.main.scale : 1
        
        
    }
    
    override func viewDidLayoutSubviews() {
        setBarChart()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DibsSpotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("OKAYYY")
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Helvetica Neue Medium 20.0
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! DibsSpotTableViewHeader
        view.title.text = self.sectionHeaderTitles[section + 1]
        return view
//        print("Header View")
//        let view = UIView()
//
//        let headerView = UITableViewHeaderFooterView()
//        headerView.textLabel!.text = "Clough Undergraduate Learning Commons"
//        headerView.textLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
//        headerView.textLabel!.textColor = UIColor.darkGray
//
////        headerView.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()
//        view.addSubview(headerView)
//        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        print(view.frame.height)
        return (view.frame.height * 0.05)
    }
    
}
