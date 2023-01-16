//
//  BarChartView.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
import Charts

extension BarChartView {
    
    // Create view
    static func createView() -> BarChartView {
        return BarChartView()
    }
    
    
    func customizeChartView() {
        let legend = self.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumIntegerDigits = 1
        leftAxisFormatter.maximumIntegerDigits = 7
        
        let xaxis = self.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        xaxis.granularity = 1
        
        let yaxis = self.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        self.rightAxis.enabled = false
        
    }
    
    func setDataWith(entries1: [(date: String, count: Int)], entries2: [(date: String, count: Int)]) {
        let dataEntry1 = entries1.enumerated().map{ (index, value) in
            return BarChartDataEntry(x: Double(index), y: Double(value.count))
        }
        let dataEntry2 = entries2.enumerated().map{(index, value) in
            return BarChartDataEntry(x: Double(index), y: Double(value.count))
        }
        
        let set1 = BarChartDataSet(entries: dataEntry1,
                                   label: "\(String.localizedString(with: "last_week")) From \(entries1.first?.date ?? "") to \(entries1.last?.date ?? "")")
        let set2 = BarChartDataSet(entries: dataEntry2,
                                   label: "\(String.localizedString(with: "week_before")) From \(entries2.first?.date ?? "") to \(entries2.last?.date ?? "")")
        
        set1.colors = [UIColor.greenColor]
        set2.colors = [UIColor.darkBlue2]
        
        
        let data = BarChartData(dataSets: [set1, set2])
        let groupSpace = 0.3
        let barSpace = 0.05
        
        let start = 0
        let groupCount = 7
        
        
        self.xAxis.axisMinimum = Double(start)
        let value = data.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        self.xAxis.axisMaximum = Double(start) + value * Double(groupCount)
        data.groupBars(fromX: Double(start), groupSpace: groupSpace, barSpace: barSpace)
        data.barWidth = 0.5
        self.data = data
        
        self.backgroundColor = .lightBlue2
        self.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
    }
    
}
