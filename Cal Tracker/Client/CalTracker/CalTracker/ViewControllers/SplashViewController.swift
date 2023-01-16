//
//  SplashViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import UIKit
import NetworkCore

class SplashViewController: UIViewController {
    
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var labelLeftTitle: UILabel!
    @IBOutlet weak var labelRightTitle: UILabel!
    
    var viewModel = SplashViewModel(userCoreManager: UserCoreManager(engine: NetworkEngine(),
                                                                     authToken: AppPreferences.shared.getUserToken()))
    
    //MARK:- View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        self.viewGradient.backgroundColor = .black.withAlphaComponent(0.8)
        titleUI()
        addLoader()
        self.viewModel.delegate = self
        self.navigateToNext()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Init UI
    func titleUI() {
        self.labelLeftTitle.font = UIFont(name: self.labelLeftTitle.font.fontName, size: 30)
        self.labelLeftTitle.textColor = UIColor.mainText
        self.labelLeftTitle.text = "cal"
        self.labelRightTitle.font = UIFont(name: self.labelRightTitle.font.fontName, size: 40)
        self.labelRightTitle.textColor = .yellow2
        self.labelRightTitle.text = "Tracker"
    }
    
    // Add activity indicator
    func addLoader() {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = UIColor.yellow2
        loader.startAnimating()
        self.view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loader.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
    
    // Navigate to sign in if user not logged in or to dashboard if user logged in
    func navigateToNext() {
        if let _ = AppPreferences.shared.getUser() {
            self.viewModel.validateUser()
            return
        }
        
        self.navigationController?.showSigninScreen()
        
    }
}

//MARK: - ViewModel delegate
extension SplashViewController: SplashViewModelDelegate {
    func userCredentialsValid() {
        DispatchQueue.main.async {
            self.navigationController?.showHomeTabBarController()
        }
    }
    
    func userCredentialsNotValid() {
        DispatchQueue.main.async {
            self.viewModel.signout()
            self.navigationController?.showSigninScreen()
        }
    }
}
