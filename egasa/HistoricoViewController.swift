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
    @IBOutlet weak var lineChartView: LineChartView!
    
    var fecha_array = [String]()
    var potencia_array = [Double]()
    var frecuencia_array = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setChart(xValues: months, yValuesLineChart: unitsSold, yValuesBarChart: unitsSold)
        readJson()
        setChartBar(dataPoints: fecha_array, values: potencia_array)
        setChartLine(dataPoints: fecha_array, values: frecuencia_array)
    }
    
    func setChartBar(dataPoints: [String], values: [Double]){
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Potencia MW")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.xAxis.enabled = false
        barChartView.chartDescription?.text = ""

    }
    
    func setChartLine(dataPoints: [String], values: [Double]){
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Frecuencia HZ")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartDataSet.colors = [UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)]
        lineChartDataSet.lineWidth = 1.0
        lineChartDataSet.drawCirclesEnabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.chartDescription?.text = ""
        
    }
    
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "charcani4_2", withExtension: "json") {
                let data = try Data(contentsOf: file)
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("entro")
                var count = 0
                if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [[String]] {
                    for i in json{
                        if count % 300 == 0{
                            fecha_array.append(i[0])
                            potencia_array.append(Double(i[1])!)
                            frecuencia_array.append(Double(i[2])!)
                        }
                        count += 1
                    }
                    
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
