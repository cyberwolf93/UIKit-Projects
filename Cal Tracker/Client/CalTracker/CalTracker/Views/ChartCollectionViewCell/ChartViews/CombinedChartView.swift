//
//  CombinedChartView.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
import Charts

extension CombinedChartView {
    
    // Create view
    static func createView() -> BarChartView {
        return BarChartView()
    }
    
    
    func customizeChartView() {
        self.drawBarShadowEnabled = false
        self.highlightFullBarEnabled = false
        self.drawOrder = [DrawOrder.bar.rawValue,
                          DrawOrder.line.rawValue]
        
        let legend = self.legend
        legend.wordWrapEnabled = true
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        
        
        self.rightAxis.enabled = false
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumIntegerDigits = 1
        leftAxisFormatter.maximumIntegerDigits = 7
        let leftAxis = self.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = self.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
    }
    
    func setDataWith(foodCaloriesPerDay: [(label: String, count: Int)], averageCalPerUser: [Int]) {
        // genrate line Chart
        let dataLineEntry = foodCaloriesPerDay.enumerated().map { (index, value) in
            return ChartDataEntry(x: Double(index+1), y: Double(averageCalPerUser[index]))
        }
        
        let lineSet = LineChartDataSet(entries: dataLineEntry, label: "Average Per user")
        lineSet.colors = [UIColor.darkRed2]
        lineSet.lineWidth = 2.5
        lineSet.circleRadius = 5
        lineSet.circleHoleRadius = 2.5
        lineSet.mode = .cubicBezier
        lineSet.drawValuesEnabled = true
        lineSet.valueFont = .systemFont(ofSize: 10)
        lineSet.valueTextColor = .black
        lineSet.axisDependency = .left
        lineSet.setCircleColor(UIColor.darkRed2)
        
        
        //Generate bar chart
        let dataBarEntry = foodCaloriesPerDay.enumerated().map { (index, value) in
            return BarChartDataEntry(x: Double(index+1), y: Double(value.count))
        }
        
        let barSet = BarChartDataSet(entries: dataBarEntry, label: "Total calories")
        barSet.colors = [UIColor.greenColor]
        barSet.axisDependency = .left
        let barData: BarChartData = [barSet]
        barData.barWidth = 0.5
        
        let data = CombinedChartData()
        data.lineData = LineChartData(dataSet: lineSet)
        data.barData = barData
        
        self.data = data
        
        self.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
    }
    
}
