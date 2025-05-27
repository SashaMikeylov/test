//
//  AnimationButton.swift
//  TestApp
//
//  Created by Александр Микейлов on 27.05.2025.
//

import UIKit

//MARK: - Базовая кнопка с анимацие нажатия

class AnimatedButton: UIButton {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addTouchAnimations()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        addTouchAnimations()
    }

    private func setupButton() {
        setTitle("Нажми меня", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        // Градиент
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)

        // Закругления и тень
        layer.cornerRadius = 16
        clipsToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func addTouchAnimations() {
        addTarget(self, action: #selector(pressDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }

    @objc private func pressDown() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction]) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc private func pressUp() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [.allowUserInteraction]) {
            self.transform = .identity
        }
    }
}

//MARK: - Кнопка с анимацией звездочек



class FancyMagicButton: UIButton {

    private let gradientLayer = CAGradientLayer()
    private let glowLayer = CALayer()
    private let particleEmitter = CAEmitterLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupGlow()
        setupParticles()
        addTouchAnimations()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupGlow()
        setupParticles()
        addTouchAnimations()
    }

    private func setupButton() {
        setTitle("✨ Магия ✨", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        gradientLayer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor,
            UIColor.systemBlue.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 20
        layer.insertSublayer(gradientLayer, at: 0)

        layer.cornerRadius = 20
        clipsToBounds = true
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.systemPink.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 15
    }

    private func setupGlow() {
        glowLayer.backgroundColor = UIColor.systemPink.withAlphaComponent(0.2).cgColor
        glowLayer.cornerRadius = 20
        glowLayer.frame = bounds
        glowLayer.opacity = 0
        layer.insertSublayer(glowLayer, below: gradientLayer)
    }

    private func setupParticles() {
        let cell = CAEmitterCell()
        cell.birthRate = 500
        cell.lifetime = 10
        cell.velocity = 1000
        cell.scale = 0.5
        cell.emissionRange = .pi * 2
        cell.contents = UIImage(systemName: "square")?.cgImage
        

        particleEmitter.emitterShape = .circle
        particleEmitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        particleEmitter.emitterSize = CGSize(width: bounds.width, height: bounds.height)
        particleEmitter.emitterCells = [cell]
        particleEmitter.birthRate = 0
        layer.addSublayer(particleEmitter)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        glowLayer.frame = bounds
        particleEmitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        particleEmitter.emitterSize = CGSize(width: bounds.width, height: bounds.height)
    }

    private func addTouchAnimations() {
        addTarget(self, action: #selector(pressDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }

    @objc private func pressDown() {
        // Сжатие
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }

        // Пульсация фона (glow)
        glowLayer.opacity = 1
        let glowPulse = CABasicAnimation(keyPath: "opacity")
        glowPulse.fromValue = 1
        glowPulse.toValue = 0
        glowPulse.duration = 0.6
        glowPulse.timingFunction = CAMediaTimingFunction(name: .easeOut)
        glowLayer.add(glowPulse, forKey: "glowPulse")
    }

    @objc private func pressUp() {
        // Упругий отскок
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: []) {
            self.transform = .identity
        }

        // Вспышка частиц
        particleEmitter.beginTime = CACurrentMediaTime()
        particleEmitter.birthRate = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.particleEmitter.birthRate = 0
        }
    }
}
