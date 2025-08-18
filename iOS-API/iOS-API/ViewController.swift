//
//  ViewController.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/18/25.
//

import UIKit

class ViewController: UIViewController {
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "초기 세팅 Test"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.clipsToBounds = true
        return label
    }() // testLabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.addSubview(testLabel)
        view.backgroundColor = .blue
    } // setUI
    
    private func setLayout() {
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
    } // setLayout
}

