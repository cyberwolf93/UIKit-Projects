//
//  ChartCollectionViewCell.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
import Charts

class ChartCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    var viewModel: ChartCollectionViewCellViewModel? {
        didSet {
            guard let viewModel else  {
                return
            }
            
            switch(viewModel.chartType) {
            case .pieChart:
                self.createPieChart()
            case .barChart:
                self.createBarChart()
            case .combinedChart:
                self.createCombinedChart()
            }
        }
    }
    
    //MARK: Chart Views
    var pieChartView: PieChartView?
    var barChartView: BarChartView?
    var combinedChartView: CombinedChartView?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addCornerRadius(with: 10)
        self.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        pieChartView?.removeFromSuperview()
        barChartView?.removeFromSuperview()
        combinedChartView?.removeFromSuperview()
    }
    
    //MARK: - Charts creation
    func createPieChart() {
        pieChartView = PieChartView.createView()
        pieChartView?.frame = self.contentView.bounds
        self.contentView.addSubview(pieChartView!)
        pieChartView?.customizeChartView()
        pieChartView?.setDataWith(entries: viewModel?.getPieCharEntries() ?? [])
        
    }
    
    func createBarChart() {
        barChartView = BarChartView()
        barChartView?.frame = self.contentView.bounds
        self.contentView.addSubview(barChartView!)
        barChartView?.customizeChartView()
        barChartView?.setDataWith(entries1: viewModel?.getBarCharEntriesGroup1() ?? [],
                                  entries2: viewModel?.getBarCharEntriesGroup2() ?? [])
    }
    
    func createCombinedChart() {
        combinedChartView = CombinedChartView()
        combinedChartView?.frame = self.contentView.bounds
        self.contentView.addSubview(combinedChartView!)
        combinedChartView?.customizeChartView()
        if let combinedBarData = self.viewModel?.getCombinedChartData() {
            combinedChartView?.setDataWith(foodCaloriesPerDay: combinedBarData.0, averageCalPerUser: combinedBarData.1)
        }
        
    }
    
    
    //MARK: - Class functions
    class func cellIdentifier() -> String {
        return "ChartCollectionViewCellIdentifier"
    }
    
    
}
