//
//  FilterByDateViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

class FilterByDateViewController: UIViewController {
    
    var textFiledFrom: UITextField?
    var textFiledTo: UITextField?
    var labelTitle: UILabel?
    var datePicker: UIDatePicker?
    var stackViewButtons: UIStackView?
    var buttonSave: UIButton?
    var buttonReset: UIButton?
    var buttonCancel: UIButton?
    
    weak var parentPresenter:UIViewController?
    var saveCompletion: (((String, String)?) -> ())?
    var from: String = ""
    var to: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print(self)
        createUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        parentPresenter?.updateStatusBarAppearance()
    }
    
    func createUI() {
        // Create Title
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 25)
        labelTitle?.text = String.localizedString(with: "filter_screen_title")
        labelTitle?.textColor = .mainTextReversed
        self.view.addSubview(labelTitle!)
        
        // Create date picker
        datePicker = UIDatePicker()
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        createTextFields()
        createStackButtons()
        createButtonsUI()
        addLayoutConstraints()

    }
    
    func createTextFields() {
        // create textField from
        textFiledFrom = UITextField()
        textFiledFrom?.inputView = datePicker
        textFiledFrom?.backgroundColor = .lightGray1
        textFiledFrom?.textColor = .black
        textFiledFrom?.text = from
        textFiledFrom?.attributedPlaceholder = NSAttributedString(string: "From",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray2])
        
        // create TextField to
        textFiledTo = UITextField()
        textFiledTo?.inputView = datePicker
        textFiledTo?.backgroundColor = .lightGray1
        textFiledTo?.textColor = .black
        textFiledTo?.text = to
        textFiledTo?.attributedPlaceholder = NSAttributedString(string: "To",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray2])
        
        self.view.addSubview(textFiledFrom!)
        self.view.addSubview(textFiledTo!)
        
    }
    
    func createButtonsUI() {
        // create button cancel
        buttonCancel = UIButton()
        buttonCancel?.setTitle("Cancel", for: .normal)
        buttonCancel?.backgroundColor = .systemGray
        buttonCancel?.setTitleColor(.mainText, for: .normal)
        buttonCancel?.addCornerRadius(with: 5)
        buttonCancel?.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        buttonReset = UIButton()
        buttonReset?.setTitle("Reset", for: .normal)
        buttonReset?.backgroundColor = .darkRed2
        buttonReset?.setTitleColor(.mainText, for: .normal)
        buttonReset?.addCornerRadius(with: 5)
        buttonReset?.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        
        // Save button
        buttonSave = UIButton()
        buttonSave?.setTitle("Save", for: .normal)
        buttonSave?.backgroundColor = .black
        buttonSave?.setTitleColor(.mainText, for: .normal)
        buttonSave?.addCornerRadius(with: 5)
        buttonSave?.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        
        
        for item in stackViewButtons!.arrangedSubviews {
            item.removeFromSuperview()
        }
        stackViewButtons?.addArrangedSubview(buttonCancel!)
        stackViewButtons?.addArrangedSubview(buttonReset!)
        stackViewButtons?.addArrangedSubview(buttonSave!)
        
        
    }
    
    func createStackButtons() {
        stackViewButtons = UIStackView()
        stackViewButtons?.axis = .horizontal
        stackViewButtons?.spacing = 20
        stackViewButtons?.distribution = .fillEqually
        self.createButtonsUI()
        self.view.addSubview(stackViewButtons!)
    }
    
    func addLayoutConstraints() {
        // Add title constraints
        labelTitle?.translatesAutoresizingMaskIntoConstraints = false
        labelTitle?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelTitle?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.1).isActive = true
        
        // textfiled from constraints
        textFiledFrom?.translatesAutoresizingMaskIntoConstraints = false
        textFiledFrom?.topAnchor.constraint(equalTo: labelTitle!.bottomAnchor, constant: 30).isActive = true
        textFiledFrom?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textFiledFrom?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        textFiledFrom?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        // textfiled to constraints
        textFiledTo?.translatesAutoresizingMaskIntoConstraints = false
        textFiledTo?.topAnchor.constraint(equalTo: textFiledFrom!.bottomAnchor, constant: 5).isActive = true
        textFiledTo?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textFiledTo?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        textFiledTo?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // stack buttons constraints
        stackViewButtons?.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtons?.topAnchor.constraint(equalTo: textFiledTo!.bottomAnchor, constant: 30).isActive = true
        stackViewButtons?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackViewButtons?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        
    }
    
    // MARK: Actions
    @objc
    func datePickerValueChanged() {
        guard let date = datePicker?.date else {
            return
        }
        

        if textFiledFrom?.isFirstResponder ?? false {
            textFiledFrom?.text = "\(Date.stringFromDate(date: date , formate: "dd-MM-yyyy"))"
        } else if textFiledTo?.isFirstResponder ?? false {
            textFiledTo?.text = "\(Date.stringFromDate(date: date , formate: "dd-MM-yyyy"))"
        }
    }
    
    @objc
    func saveButtonClicked() {
        guard let dateFrom = textFiledFrom?.text else {
            self.saveCompletion?(nil)
            return
        }
        
        guard let dateTo = textFiledTo?.text else {
            self.saveCompletion?(nil)
            return
        }
        
        self.saveCompletion?((dateFrom, dateTo))
        self.dismiss(animated: true)
    }
    
    @objc
    func resetButtonClicked() {
        self.saveCompletion?(("", ""))
        self.dismiss(animated: true)
    }
    
    @objc
    func cancelButtonClicked() {
        self.saveCompletion?(nil)
        self.dismiss(animated: true)
    }
}
