//
//  UIManager.swift
//  MarvelFireBase
//
//  Created by Macbook on 9/12/23.
//

import UIKit

protocol UIManagerFactoryProtocol {
    
    func heroImageView() -> UIImageView
    func nameLabel() -> UILabel
    func descriptionLabel() -> UILabel
    func vStack() -> UIStackView
    func spider_man_button() -> UIButton
    func dead_pool_button() -> UIButton
    func venom_button() -> UIButton
    func hStack() -> UIStackView
    func spinner() -> UIActivityIndicatorView
}

final class UIManagerFactory: UIManagerFactoryProtocol {
    
    func heroImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }
    
    func nameLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Name label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func descriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Description label"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func vStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }
    
    func spider_man_button() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 30))
        button.setTitle("Spider-Man", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        return button
    }
    
    func dead_pool_button() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 30))
        button.setTitle("Dead Pool", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        return button
    }
    
    func venom_button() -> UIButton {
        let button = UIButton()
        button.setTitle("Venom", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black.withAlphaComponent(0.5)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        return button
    }
    
    func hStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }
    
    func spinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintAdjustmentMode = .normal
        spinner.color = .red
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }
}
