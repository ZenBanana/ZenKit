//
//  ZB-ViewControllerAnimations.swift
//  safe-ios
//
//  Created by Tanner Juby on 6/21/17.
//  Copyright © 2017 com.zenbanana. All rights reserved.
//

import Foundation
import UIKit

class PresentFromBottomAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        
        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            toViewController.view.frame = finalFrameForVC
            
        }, completion: { _ in
            
            fromViewController.removeFromParentViewController()
            transitionContext.completeTransition(true)

        })
        
    }
}

class DismissFromTopAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        toViewController.view.frame = finalFrameForVC
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            fromViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
            
        }, completion: { _ in
            
            fromViewController.removeFromParentViewController()
            transitionContext.completeTransition(true)
        })
        
    }
}

class ExpandFromMiddleAnimation : NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        let maskPath = UIBezierPath(ovalIn: CGRect(x: fromViewController.view.frame.midX, y: fromViewController.view.frame.midY, width: 0, height: 0))
        
        // define the masking layer to be able to show that circle animation
        let maskLayer = CAShapeLayer()
        maskLayer.frame = toViewController.view.frame
        maskLayer.path = maskPath.cgPath
        toViewController.view.layer.mask = maskLayer
        
        // define the end frame
        let tempX = 0 - (containerView.frame.width / 4)
        let tempY = 0 - (containerView.frame.height / 4)
        let finalFrame = CGRect(x: tempX, y: tempY, width: containerView.frame.width*1.5, height: containerView.frame.height*1.5)
        let bigCirclePath = UIBezierPath(ovalIn: finalFrame)
        
        // create the animation
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.cgPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayer.path = bigCirclePath.cgPath
        maskLayer.add(pathAnimation, forKey: "pathAnimation")
        
        UIView.animate(withDuration: 0.3, animations: {
            
            
            fromViewController.view.alpha = 0
        
        }, completion: { _ in
            
            toViewController.view.layer.mask?.removeFromSuperlayer()
            fromViewController.removeFromParentViewController()
            transitionContext.completeTransition(true)
        })
        
    }
}

class CollapseToMiddleAnimation : NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        
        // define the end frame
        let tempX = 0 - (containerView.frame.width / 4)
        let tempY = 0 - (containerView.frame.height / 4)
        let finalFrame = CGRect(x: tempX, y: tempY, width: containerView.frame.width*1.5, height: containerView.frame.height*1.5)
        let maskPath = UIBezierPath(ovalIn: finalFrame)
        
        // define the masking layer to be able to show that circle animation
        let maskLayer = CAShapeLayer()
        maskLayer.frame = fromViewController.view.frame
        maskLayer.path = maskPath.cgPath
        fromViewController.view.layer.mask = maskLayer
        
        // define the end frame
        let bigCirclePath = UIBezierPath(ovalIn: CGRect(x: fromViewController.view.frame.midX, y: fromViewController.view.frame.midY, width: 0, height: 0))
        
        // create the animation
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.cgPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayer.path = bigCirclePath.cgPath
        maskLayer.add(pathAnimation, forKey: "pathAnimation")
        
        UIView.animate(withDuration: 0.3, animations: {
            
            fromViewController.view.alpha = 0
            
        }, completion: { _ in
            
            fromViewController.removeFromParentViewController()
            transitionContext.completeTransition(true)
        })
        
    }
}


