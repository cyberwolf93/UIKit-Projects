//
//  PieChartView.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
import Charts

extension PieChartView {
    
    // Create view
    static func createView() -> PieChartView {
        return PieChartView()
    }
    
    
    func customizeChartView() {
        self.usePercentValuesEnabled = true
        self.drawSlicesUnderHoleEnabled = false
        self.holeRadiusPercent = 0.58
        self.transparentCircleRadiusPercent = 0.61
        self.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        self.drawCenterTextEnabled = true
        self.entryLabelColor = .white
        self.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        self.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    func setDataWith(entries: [(label: String, count: Int)]) {
        var sum = 0
        entries.forEach { (label: String, count: Int) in
            sum += count
        }
        
        
        
        let dataEntry = entries.map { PieChartDataEntry(value: Double($0.count)/Double(sum) * 100, label: $0.label) }
        let set = PieChartDataSet(entries: dataEntry)
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        set.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: set)
        // Formate data
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        self.data = data
        self.highlightValues(nil)
    }
    
}
