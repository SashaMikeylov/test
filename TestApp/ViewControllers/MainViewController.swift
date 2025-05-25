//
//  ViewController.swift
//  TestApp
//
//  Created by Александр Микейлов on 25.05.2025.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var button = UIButton()
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    private func layout() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

}

