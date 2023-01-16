//
//  ViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import UIKit
import NetworkCore

class SigninViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var labelLeftTitle: UILabel!
    @IBOutlet weak var labelRightTitle: UILabel!
    @IBOutlet weak var imageViewEmail: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var imageViewPassword: UIImageView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSignin: UIButton!
    @IBOutlet weak var viewGradient: UIView!
    
    //MARK:- Variables
    var viewModel = SigninViewModel(userCoreManager: UserCoreManager(engine: NetworkEngine(),
                                                                        authToken: ""))
    
    //MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        self.view.backgroundColor = .clear
        self.viewGradient.backgroundColor = .black.withAlphaComponent(0.8)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.titleUI()
        self.inputUI()
        self.buttonUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewWillLayoutSubviews() {
        textFieldEmail.paddingLeftAndRight(with: 10)
        textFieldPassword.paddingLeftAndRight(with: 10)
        buttonSignin.addCornerRadius(with: 5)
        
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
    
    
    func inputUI() {
        imageViewEmail.image = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageViewPassword.image = UIImage(systemName: "lock.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        textFieldEmail.backgroundColor = .clear
        textFieldEmail.tintColor = .yellow2
        textFieldEmail.addBottomBorder(frame: CGRect(x: 0, y: textFieldEmail.bounds.maxY, width: textFieldEmail.frame.width - textFieldEmail.frame.origin.x, height: 0.8),
                                       color: UIColor.lightGray.withAlphaComponent(0.5))
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: String.localizedString(with: "email"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3), NSAttributedString.Key.font : UIFont(name: textFieldEmail.font?.fontName ?? "", size: 20)])
        
        textFieldPassword.backgroundColor = .clear
        textFieldPassword.tintColor = .yellow2
        textFieldPassword.addBottomBorder(frame: CGRect(x: 0, y: textFieldPassword.bounds.maxY, width: textFieldPassword.frame.width - textFieldPassword.frame.origin.x, height: 0.8),
                                          color: UIColor.lightGray.withAlphaComponent(0.5))
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: String.localizedString(with: "password"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3), NSAttributedString.Key.font : UIFont(name: textFieldEmail.font?.fontName ?? "", size: 20)])
    }
    
    func buttonUI() {
        buttonSignin.setTitle(String.localizedString(with: "signin"), for: .normal)
        buttonSignin.setTitleColor(.mainText, for: .normal)
        buttonSignin.backgroundColor = .clear
        buttonSignin.addGradientLeftToRight(with: [UIColor.yellow1.cgColor, UIColor.yellow2.cgColor])
    }
    
    //MARK:- Acoin methods
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func buttonSigninClicked(_ sender: Any) {
        guard let email = textFieldEmail.text, !email.isEmpty else {
            return
        }
        
        guard let password = textFieldPassword.text, !password.isEmpty else {
            return
        }
        
        self.view.showLoading()
        self.viewModel.signin(email: email, password: password)
    }
    

}

//MARK:- Handle view model delegate
extension SigninViewController: SigninViewModelDelegate {
    func signinDidSucceeded() {
        DispatchQueue.main.async { [weak self] in
            self?.view.hideLoading()
            self?.navigationController?.showHomeTabBarController()
        }
        
        
    }
    
    func signinDidFailed(error: Error?) {
        DispatchQueue.main.async { [weak self] in
            self?.view.hideLoading()
            self?.showErrorAlert(message: String.localizedString(with: "login_failed"))
        }
    }
}

