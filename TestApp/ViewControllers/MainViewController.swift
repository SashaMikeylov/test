//
//  ViewController.swift
//  TestApp
//
//  Created by Александр Микейлов on 25.05.2025.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var mainView = MainView()
    
    //MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = mainView
    }

}

