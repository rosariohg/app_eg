//
//  HistoricoViewController.swift
//  egasa
//
//  Created by rosario on 8/1/17.
//  Copyright © 2017 rosario. All rights reserved.
//

import UIKit
import Charts

class HistoricoViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var grafico1ChartView: CombinedChartView!
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart(xValues: months, yValuesLineChart: unitsSold, yValuesBarChart: unitsSold)
    }
    
    func setChart(xValues:[String], yValuesLineChart: [Double], yValuesBarChart: [Double]){
        grafico1ChartView.noDataText = "...."
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()
        let tam = 50
        
        for i in 0..<tam{
            yVals1.append(ChartDataEntry(x: Double(i), y: Double(i)))
            yVals2.append(BarChartDataEntry(x: Double(2*i), y: Double(i)))
        }
        
        let lineCharSet = LineChartDataSet(values: yVals1, label: "Line Data")
        lineCharSet.colors = [UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)]
        lineCharSet.lineWidth = 5.0
        lineCharSet.drawCirclesEnabled = false
        
        
        let barCharSet : BarChartDataSet = BarChartDataSet(values: yVals2, label: "Bar Data")
        
        
        let data : CombinedChartData = CombinedChartData()
        data.barData = BarChartData(dataSets: [barCharSet])
        data.lineData = LineChartData(dataSets: [lineCharSet])
        
        grafico1ChartView.data = data
        
    }

}
