//
//  ReportViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
import NetworkCore

class ReportViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var ViewParent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    let viewModel = ReportViewModel(userCoreManager: UserCoreManager(engine: NetworkEngine(),
                                                                     authToken: AppPreferences.shared.getUserToken()),
                                    foodCoremanager: FoodEntryCoreManager(engine: NetworkEngine(),
                                                                          authToken: AppPreferences.shared.getUserToken()))
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.ViewParent.backgroundColor = .clear
        self.ViewParent.addGradientBackground(with: [UIColor.darkBlue1.cgColor, UIColor.darkBlue2.cgColor])
        self.viewModel.delegate = self
        self.view.showLoading()
        self.viewModel.initViewModel()
        prepareCollectionView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func prepareCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Register cells
        collectionView.register(ChartCollectionViewCell.self,
                                forCellWithReuseIdentifier: ChartCollectionViewCell.cellIdentifier())
        collectionView.register(ReportDetailsCollectionCell.cellNib(),
                                forCellWithReuseIdentifier: ReportDetailsCollectionCell.cellIdentifier())
        
    }
}

// MARK: - Collection view delegate and data source
extension ReportViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.collectionViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = ReportViewModel.Section(rawValue: indexPath.section)
        let rowType = viewModel.collectionViewList[indexPath.section][indexPath.row]
        
        switch (sectionType, rowType) {
        case (.entriesCountPieChart, .detailsRow):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportDetailsCollectionCell.cellIdentifier(),
                                                          for: indexPath) as! ReportDetailsCollectionCell
            
            cell.configureCell(labelFirst: viewModel.getLastWeekEntriesNumberLabel(),
                               labelSecond: viewModel.getWeekBeforeEntriesNumberLabel())
            return cell
            
        case (.entriesCountBarChart, .detailsRow):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportDetailsCollectionCell.cellIdentifier(),
                                                          for: indexPath) as! ReportDetailsCollectionCell
            
            cell.configureCell(labelFirst: viewModel.getLastWeekEntriesNumberLabel(),
                               labelSecond: viewModel.getWeekBeforeEntriesNumberLabel())
            return cell
            
        case (.entriesCountCombinedChart, .detailsRow):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportDetailsCollectionCell.cellIdentifier(),
                                                          for: indexPath) as! ReportDetailsCollectionCell
            
            cell.configureCell(labelFirst: "\(String.localizedString(with: "average_calories_title")):",
                               labelSecond: "\(viewModel.getAverageCaloriesPerUserLabel())",
                               showMore: true)
            cell.delegate = self
            return cell
            
        case (.entriesCountPieChart, .pieChartRow):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.cellIdentifier(),
                                                          for: indexPath) as! ChartCollectionViewCell
            let viewModel = ChartCollectionViewCellViewModel(chartType: .pieChart, pieChartDataEntries: viewModel.getPieChartData())
            cell.viewModel = viewModel
            return cell
            
        case (.entriesCountBarChart, .barChartRow):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.cellIdentifier(),
                                                          for: indexPath) as! ChartCollectionViewCell
            let viewModel = ChartCollectionViewCellViewModel(chartType: .barChart, barChartDataEntries:  self.viewModel.getBarChartData())
            cell.viewModel = viewModel
            return cell
        case (.entriesCountCombinedChart, .combinedChartRow):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.cellIdentifier(),
                                                          for: indexPath) as! ChartCollectionViewCell
            let viewModel = ChartCollectionViewCellViewModel(chartType: .combinedChart, combinedChartDataEntries:  self.viewModel.getCombinedBarChart())
            cell.viewModel = viewModel
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionType = ReportViewModel.Section(rawValue: indexPath.section)
        let rowType = viewModel.collectionViewList[indexPath.section][indexPath.row]
        
        switch(sectionType, rowType) {
        case (.entriesCountPieChart, .detailsRow),
            (.entriesCountBarChart, .detailsRow),
            (.entriesCountCombinedChart, .detailsRow):
            return CGSize(width: collectionView.frame.width - 10, height: 100)
        case (.entriesCountPieChart, .pieChartRow):
            return CGSize(width: collectionView.frame.width - 10, height: 400)
        case (.entriesCountBarChart, .barChartRow):
            return CGSize(width: collectionView.frame.width - 10, height: 300)
        case (.entriesCountCombinedChart, .combinedChartRow):
            return CGSize(width: collectionView.frame.width - 10, height: 300)
        default:
            break
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}


//MARK: - ReportViewModelDelegate

extension ReportViewController: ReportViewModelDelegate {
    func reportDataIsReady() {
        DispatchQueue.main.async {
            self.view.hideLoading()
            self.collectionView.reloadData()
        }
    }
    
    func failedToPrepareReportData() {
        DispatchQueue.main.async {
            self.view.hideLoading()
            
        }
    }
}

extension ReportViewController: ReportDetailsCollectionCellDelegate {
    func buttonMoreDidClikced() {
        // Show average calories for each user in last week
        // Create average list View Controller
        let viewController = AverageCaloriesViewController()
        viewController.usersList = self.viewModel.usersList
        viewController.totalCalPerUser = self.viewModel.totalCalPerUserLastWeek
        viewController.parentPresenter = self
        
        // create navigation crontroller for Calories list view controller
        let navigationController = UINavigationController()
        navigationController.addChild(viewController)
        navigationController.modalPresentationStyle = .pageSheet
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        
        
        self.present(navigationController, animated: true)
    }
}
