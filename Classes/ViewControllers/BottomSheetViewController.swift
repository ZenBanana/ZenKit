//
//  BottomSheetViewController.swift
//  ZenBanana LLC
//
//  Created by Tanner Juby on 1/9/17.
//  Copyright © 2017 ZenBanana LLP. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: UIOutlets and Variables
    
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - View Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.bottomSheetFullClosePanGesture))
        view.addGestureRecognizer(panGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height * 0.075
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
            self?.view.roundCorners(withRadius: (self?.view.frame.height)! / 30)
            
            self?.view.addShadow(opacity: 0.45, yOffset: -2, xOffset: 2, radius: (self?.view.layer.cornerRadius)!)
            
            
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    
    // MARK: Controller Functions
    
    // MARK: Actions
    
    @IBAction func closeButtonSelected(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: { (true) in
            self.view.removeFromSuperview()
        })
        
    }
    
    // MARK: - Navigation Controller Delegate
    
    /**
     Animates the View transition
     */
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == UINavigationControllerOperation.push {
            // MARK: TODO - Return Animation for transitioning to a new screen
            
        }
        
        if operation == UINavigationControllerOperation.pop {
            // MARK: TODO - Return Animation for dismissing this view
        }
        
        return nil
    }
 

}
