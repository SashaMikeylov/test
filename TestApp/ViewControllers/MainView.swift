//
//  MainView.swift
//  TestApp
//
//  Created by Александр Микейлов on 27.05.2025.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    private lazy var button = FancyMagicButton()
    
    //MARK: - Life
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        buttonSetup()
        backgroundColor = .white
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func buttonSetup() {
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        print("effed")
        
        
    }
}
