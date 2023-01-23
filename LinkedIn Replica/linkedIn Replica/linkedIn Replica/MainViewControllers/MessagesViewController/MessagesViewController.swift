//
//  MessagesViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 18/01/2023.
//

import UIKit

class MessagesViewController: UIViewController, DescendantforContainerTransitionController {
    
    //MARK: Variables
    static let storyboardId: String = "MessagesViewControllerVCID"
    weak var mainContainerTransitionController: MainContainerTransitionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        addViewTransitionPanGesture()
    }
    
    func addViewTransitionPanGesture(){
        if let transitionContainer = self.mainContainerTransitionController {
            let gesture = UIPanGestureRecognizer(target: transitionContainer, action: #selector(transitionContainer.handlePanGestureRecognizer(_:)))
            self.view.addGestureRecognizer(gesture)
        }
    }
}
