//
//  ViewController.swift
//  вя15
//
//  Created by Akhmed Mongush on 16/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let button = UIButton()
    private var blurEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties ()
        setupSubviews()
        setupConstraints()
        
    }
    
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    private func setupSubviews() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemRed.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        gradient.cornerRadius = 25
        
        button.layer.insertSublayer(gradient, at: 0)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.alpha = 0
        
        if let blurView = blurEffectView {
            view.addSubview(blurView)
            
            UIView.animate(withDuration: 0.3) {
                blurView.alpha = 1
            }
        }
    }
    
    private func removeBlurEffect() {
        UIView.animate(withDuration: 0.05, animations: {
            self.blurEffectView?.alpha = 0
        }) { _ in
            self.blurEffectView?.removeFromSuperview()
            self.blurEffectView = nil
        }
    }
    
    @objc func buttonTapped() {
        addBlurEffect()
        let alert = UIAlertController(title: "Task completed", message: "Congrats! You've successfully completed the task.", preferredStyle: .alert)
        let action = UIAlertAction(title: "I know",  style: .default) { [weak self] _ in
            self?.removeBlurEffect()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

