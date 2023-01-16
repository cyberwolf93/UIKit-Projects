//
//  AddFoodEntryViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 24/10/2022.
//

import UIKit
import NetworkCore
import SDWebImage

protocol AddFoodEntryViewControllerDelegate: NSObjectProtocol {
    func notifyParent()
}

enum AddFoodScreenMode {
    case add
    case edit
}

class AddFoodEntryViewController: UIViewController {
    
    //MARK: Outlets and Views
    
    @IBOutlet weak var ViewParent: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var labelCalValue: UILabel!
    @IBOutlet weak var textFieldCalValue: UITextField!
    @IBOutlet weak var segmentedChoosePhotoSelection: UISegmentedControl!
    @IBOutlet weak var imageViewSelectedImage: UIImageView!
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var textFieldTime: UITextField!
    @IBOutlet weak var buttonAddDate: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    var imagePicker: UIImagePickerController?
    var datePickerView: UIDatePicker?
    var buttonDonePickerView: UIBarButtonItem?
    var datePickerViewToolBar: UIToolbar?
    
    
    
    
    //MARK: Varibles
    var selectedUserId: String = ""
    var photoSelection: UIImagePickerController.SourceType = .camera
    let viewModel = AddEntryViewModel(foodEntryCoreManager: FoodEntryCoreManager(engine: NetworkEngine(), authToken: AppPreferences.shared.getUserToken()))
    weak var parentPresenter: AddFoodEntryViewControllerDelegate?
    var oldFoodEntry: FoodEntry?
    var screenMode: AddFoodScreenMode = .add
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewParent.backgroundColor = .lightBlue1
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        viewModel.delegate = self
        viewModel.screenMode = screenMode
        labelUI()
        textFieldUI()
        selectImageUI()
        DatePickerUI()
    }
    
    override func viewWillLayoutSubviews() {
        buttonAddDate.addCornerRadius(with: 5)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let parent = parentPresenter as? UIViewController {
            parent.updateStatusBarAppearance()
        }
    }
    
    // MARK: Handle UI customization
    func labelUI() {
        
        self.labelTitle.font = UIFont(name: self.labelTitle.font.fontName, size: 30)
        self.labelTitle.textColor = UIColor.mainTextReversed
        self.labelTitle.text = self.viewModel.getScreenTitle()
        
        self.labelName.font = UIFont(name: self.labelName.font.fontName, size: 20)
        self.labelName.textColor = UIColor.mainTextReversed
        self.labelName.text = String.localizedString(with: "entry_name_lable")
        
        self.labelCalValue.font = UIFont(name: self.labelCalValue.font.fontName, size: 20)
        self.labelCalValue.textColor = UIColor.mainTextReversed
        self.labelCalValue.text = String.localizedString(with: "cal_value")
    }
    
    func textFieldUI() {
        // Entry name text field
        textFieldName.backgroundColor = .white
        textFieldName.tintColor = .yellow2
        textFieldName.textColor = .mainTextReversed
        textFieldName.text = oldFoodEntry?.name
        
        // Calories value text field
        textFieldCalValue.backgroundColor = .white
        textFieldCalValue.textColor = .mainTextReversed
        textFieldCalValue.tintColor = .yellow2
        textFieldCalValue.delegate = self
        textFieldCalValue.text = oldFoodEntry != nil ? "\(oldFoodEntry!.calValue)" : nil
        
    }
    
    func selectImageUI() {
        self.segmentedChoosePhotoSelection.addTarget(self, action: #selector(segmentedClicked(sender:)), for: .valueChanged)
        self.imageViewSelectedImage.sd_setImage(with: URL(string: PlistManager.shared.base_url + (oldFoodEntry?.thumbUrl ?? "")))
    }
    
    func DatePickerUI() {
        textFieldDate.textColor = .mainTextReversed
        textFieldDate.font = UIFont.systemFont(ofSize: 15)
        textFieldDate.isEnabled = false
        textFieldDate.backgroundColor = .white
        textFieldDate.attributedPlaceholder = NSAttributedString(string: String.localizedString(with: "date"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainTextReversed])
        textFieldDate.text = self.oldFoodEntry?.date
        
        textFieldTime.textColor = .mainTextReversed
        textFieldTime.font = UIFont.systemFont(ofSize: 15)
        textFieldTime.isEnabled = false
        textFieldTime.backgroundColor = .white
        textFieldTime.attributedPlaceholder = NSAttributedString(string: String.localizedString(with: "time"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainTextReversed])
        textFieldTime.text = self.oldFoodEntry?.time
        
        buttonAddDate.backgroundColor = .black
        buttonAddDate.setTitle("Add", for: .normal)
        buttonAddDate.setTitleColor(.mainText, for: .normal)
        buttonAddDate.isEnabled = self.viewModel.shouldEnableAddDateButton()
        
        createUIDatePickerView()
    }
    
    func createUIDatePickerView() {
        datePickerView = UIDatePicker()
        datePickerView?.preferredDatePickerStyle = .wheels
        datePickerView?.addTarget(self, action: #selector(dateDidChanged), for: .valueChanged)
        datePickerView?.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        datePickerView?.backgroundColor = .lightGray2
        
        
        // create tool bar and add done button to it
        buttonDonePickerView = UIBarButtonItem()
        buttonDonePickerView?.title = "Done"
        buttonDonePickerView?.target = self
        buttonDonePickerView?.action = #selector(datePickerDoneEditing)
        
        datePickerViewToolBar = UIToolbar()
        datePickerViewToolBar?.sizeToFit()
        datePickerViewToolBar?.barStyle = .default
        datePickerViewToolBar?.setItems([buttonDonePickerView!], animated: true)
        datePickerViewToolBar?.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50)
        datePickerViewToolBar?.backgroundColor = .lightGray1
        datePickerViewToolBar?.barTintColor = .lightGray1
        
    }
    
    // MARK: Actions
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        // Show message error if name is empty
        guard let entryName = textFieldName.text, !entryName.isEmpty else {
            self.showErrorAlert(message: String.localizedString(with: "should_write_name"))
            return
        }
        
        // Show message error if there is no calories value
        guard let calValue = textFieldCalValue.text, !calValue.isEmpty else {
            self.showErrorAlert(message: String.localizedString(with: "should_write_cal"))
            return
        }
        
        // Show message error if image not selected
        guard let image = self.imageViewSelectedImage.image else {
            self.showErrorAlert(message: String.localizedString(with: "should_select_image"))
            return
        }
        
        // Show message error if there is no date have been picked
        guard let dateText = self.textFieldDate.text, !dateText.isEmpty else {
            self.showErrorAlert(message: String.localizedString(with: "should_select_time_and_date"))
            return
        }
        
        // Show message error if there is no time have been picked
        guard let timeText = self.textFieldTime.text, !timeText.isEmpty else {
            self.showErrorAlert(message: String.localizedString(with: "should_select_time_and_date"))
            return
        }
        
        
        // Show message error if failed to get image as data
        guard let imageData = self.viewModel.getImageData(from: image) else {
            self.showErrorAlert(message: String.localizedString(with: "image_encoder_error"))
            return
        }
        
        guard let dateInTimestamp = Date.dateFrom(string: dateText, formate: "dd-MM-yyy") else {
            self.showErrorAlert(message: String.localizedString(with: "failed_to_formate_date"))
            return
        }
        
        let foodEntry = FoodEntry(id: "",
                                  name: entryName,
                                  userId: self.selectedUserId,
                                  thumbUrl: "",
                                  date: dateText,
                                  time: timeText,
                                  timestamp: Int(dateInTimestamp.timeIntervalSince1970),
                                  calValue: Int(calValue) ?? 0)
        
        self.view.showLoading()
        self.view.isUserInteractionEnabled = false
        self.viewModel.saveFoodEntry(foodEntry: foodEntry, image: imageData, oldEntry: self.oldFoodEntry)
        
    }
    
    // Change segmented option
    @objc
    func segmentedClicked(sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            self.photoSelection = .camera
        case 1:
            self.photoSelection = .photoLibrary
        default:
            break
        }
    }
    
    @IBAction func buttonAddImageClicked(_ sender: Any) {
        if imagePicker == nil {
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
        }
        
        imagePicker?.sourceType = photoSelection
        imagePicker?.allowsEditing = true
        
        if let imagePicker = imagePicker {
            present(imagePicker, animated: true)
        }
    }
    
    @IBAction func ButtonAddDateClicked(_ sender: Any) {
        if let datePicker = datePickerView, let toolBar = datePickerViewToolBar {
            self.view.addSubview(datePicker)
            self.view.addSubview(toolBar)
        }
        
    }
    
    // add selected date and time to text fields
    @objc
    func dateDidChanged() {
        guard let date = datePickerView?.date else {
            return
        }
        // formate date like 24-10-2022
        self.textFieldDate.text = Date.stringFromDate(date: date, formate: "dd-MM-yyyy")
        
        // formate time like 11:33
        let timeFormater = DateFormatter()
        timeFormater.dateFormat = "HH:mm"
        let timeText = timeFormater.string(from: date)
        self.textFieldTime.text = timeText
    }
    
    @objc
    func datePickerDoneEditing() {
        datePickerView?.removeFromSuperview()
        datePickerViewToolBar?.removeFromSuperview()
    }
    
}

// Image picker delegate
extension AddFoodEntryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.imageViewSelectedImage.image = image
    }
}

// UItextField delegate
extension AddFoodEntryViewController: UITextFieldDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Handle only calories text field to enter numbers only
        if let _ = text.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
            return true
        }
        
        return false
    }
}


// MARK: ViewModel Delegate
extension AddFoodEntryViewController: AddEntryViewModelDelegate {
    func addEntryDidSucceeded() {
        DispatchQueue.main.async {
            self.view.hideLoading()
            self.parentPresenter?.notifyParent()
            self.view.isUserInteractionEnabled = false
            self.dismiss(animated: true)
        }
    }
    
    func addEntryDidFailed(error: Error?) {
        DispatchQueue.main.async {
            self.view.hideLoading()
            self.view.isUserInteractionEnabled = false
            self.showErrorAlert(message: String.localizedString(with: "failed_to_create_food_entry"))
        }
    }
}


