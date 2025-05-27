//
//  аааа.swift
//  TestApp
//
//  Created by Александр Микейлов on 27.05.2025.
//


import UIKit


class SampleViewController: UIViewController {
    init(color: UIColor, title: String) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = color
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

class AnimatedTabBarController: UITabBarController, UITabBarControllerDelegate {

    private let highlightView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
        styleTabBar()
        setupHighlightView()
    }

    private func setupViewControllers() {
        let homeVC = SampleViewController(color: .systemBlue, title: "Главная")
        let searchVC = SampleViewController(color: .systemTeal, title: "Поиск")
        let profileVC = SampleViewController(color: .systemPurple, title: "Профиль")

        viewControllers = [
            createNavController(for: homeVC, title: "Главная", image: UIImage(systemName: "house.fill")!),
            createNavController(for: searchVC, title: "Поиск", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: profileVC, title: "Профиль", image: UIImage(systemName: "person.crop.circle.fill")!)
        ]
    }

    private func createNavController(for root: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }

    private func styleTabBar() {
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -6)
        tabBar.layer.shadowRadius = 15

        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.4)
        tabBar.backgroundColor = .clear

        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blurView, at: 0)
    }

    private func setupHighlightView() {
        highlightView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        highlightView.layer.cornerRadius = 18
        tabBar.addSubview(highlightView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHighlightPosition(animated: false)
    }

    private func updateHighlightPosition(animated: Bool) {
        guard let items = tabBar.items, let selectedIndex = selectedIndex as Int?,
              let tabBarButton = tabBar.subviews.filter({ $0 is UIControl })[safe: selectedIndex] else { return }

        let targetFrame = tabBarButton.frame.insetBy(dx: 0, dy: 20)

        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
                self.highlightView.frame = targetFrame
            }
        } else {
            highlightView.frame = targetFrame
        }
    }

    // Анимация при выборе таба
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateHighlightPosition(animated: true)

        guard let index = viewControllers?.firstIndex(of: viewController),
              let tabBarButtons = tabBar.subviews.filter({ $0 is UIControl }) as? [UIView],
              index < tabBarButtons.count else { return }

        let selectedTab = tabBarButtons[index]

        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.duration = 0.4
        pulse.initialVelocity = 0.6
        pulse.damping = 0.6
        selectedTab.layer.add(pulse, forKey: nil)
    }
}



extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
