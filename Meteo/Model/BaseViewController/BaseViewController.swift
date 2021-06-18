//
//  BaseViewController.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    
    private var lottieContainer = UIView()
    private var loadingView = AnimationView()
    var animationIsNeeded: Bool = false {
        didSet {
            if animationIsNeeded {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.setupAnimation()
                }
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.loadingView.stop()
                    self.lottieContainer.removeFromSuperview()
                }
            }
        }
    }
    
    
    private func setupAnimation() {
        guard let animation = Animation.named("loading") else { return }
        lottieContainer.backgroundColor = .white
        loadingView.frame = animation.bounds
        loadingView.animation = animation
        loadingView.contentMode = .scaleAspectFill
        loadingView.backgroundBehavior = .pauseAndRestore
        ConstraintBuilder.setupAllEdgesConstrainFor(child: lottieContainer, into: self.view)
        self.view.bringSubviewToFront(lottieContainer)
        ConstraintBuilder.setupAllEdgesConstrainFor(child: loadingView, into: lottieContainer)
        loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
}
