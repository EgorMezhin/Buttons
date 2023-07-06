//
//  ViewController.swift
//  Buttons
//
//  Created by Egor Mezhin on 05.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Constants
    private enum Title: String {
        case first = "First"
        case secondMedium = "Second Button"
        case thirdLong = "Third Very Long Button"
    }
    private struct Constants {
        static let white = UIColor.white
        static let blue = UIColor.systemBlue
        static let gray = UIColor.gray
        static let image = UIImage(systemName: "tortoise.fill")
        static let verticalInset = 10.0
        static let horizontalInset = 14.0
        static let imagePadding = 8.0
        static let corenerRadius = 10.0
        static let verticalPadding = 10.0
        static let largeVerticalPadding = 30.0
    }
    
    private lazy var firstButton: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var secondButton: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var thirdButton: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        button.addTarget(self, action: #selector(self.showModalViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let secondVC = SecondViewController()

    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private methods
extension ViewController {
    private func setupView() {
        configureButton(firstButton,
                        with: Title.first.rawValue)
        configureButton(secondButton,
                        with: Title.secondMedium.rawValue)
        configureButton(thirdButton,
                        with: Title.thirdLong.rawValue)
        addSubview()
        configureConstarints()
    }
    
    private func configureButton(_ button: UIButton,
                                 with text: String) {
        button.configuration = UIButton.Configuration.borderless()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: Constants.verticalInset,
                                                                      leading: Constants.horizontalInset,
                                                                      bottom: Constants.verticalInset,
                                                                      trailing: Constants.horizontalInset)
        button.configuration?.image = Constants.image
        button.configuration?.imagePlacement = .trailing
        button.configuration?.imagePadding = Constants.imagePadding
        button.setTitle(text, for: .normal)
        button.tintColor = Constants.white
    
        button.layer.cornerRadius = Constants.corenerRadius
    }
    
    private func addSubview() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
    }
    
    private func configureConstarints() {
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.largeVerticalPadding),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: Constants.verticalPadding),
            secondButton.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor),
            
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: Constants.verticalPadding),
            thirdButton.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor)
        ])
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 3,
                           options: [.curveEaseInOut, .allowUserInteraction],
                           animations: {
                            button.transform = transform
                }, completion: nil)
        }
}

// MARK: - Buttons methods
extension ViewController {
    @objc
    private func showModalViewController() {
        present(secondVC, animated: true)
    }
    
    @objc
    private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9))
    }
    
    @objc
    private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
}


class CustomButton: UIButton {
}

extension CustomButton {
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        tintAdjustmentMode = .automatic
        if tintAdjustmentMode.rawValue == 1 {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .gray
        }
    }
}

