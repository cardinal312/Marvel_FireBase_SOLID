//
//  ViewController.swift
//  MarvelFireBase
//
//  Created by Macbook on 8/12/23.
//

import UIKit

final class MarverViewController: UIViewController {
    
    //MARK: - Veriables
    private var dataBaseManager: DataBaseManagerProtocol
    
    //MARK: - UI Components
    private let heroImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Name label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Description label"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let spider_man_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 30))
        button.setTitle("Spider-Man", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.tintColor = .white
        button.addTarget(self, action: #selector(spider_man_tapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let dead_pool_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 30))
        button.setTitle("Dead Pool", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dead_pool_tapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let venom_button: UIButton = {
        let button = UIButton()
        button.setTitle("Venom", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black.withAlphaComponent(0.5)
        button.tintColor = .white
        button.addTarget(self, action: #selector(venom_tapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - Lifecycle
    init(dataBaseManager: DataBaseManagerProtocol) {
        self.dataBaseManager = dataBaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "MARVEL 🔥"
        navigationController?.navigationBar.prefersLargeTitles = true
        confifureUI()
    }
    
    private func confifureUI() {
        view.addSubview(heroImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(vStack)
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heroImageView.heightAnchor.constraint(equalToConstant: 300),
            heroImageView.widthAnchor.constraint(equalToConstant: 300),
            heroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 20),
            vStack.heightAnchor.constraint(equalToConstant: 80),
            vStack.widthAnchor.constraint(equalToConstant: 300),
            vStack.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor)
        ])
        
        view.addSubview(spider_man_button)
        view.addSubview(dead_pool_button)
        view.addSubview(venom_button)
        view.addSubview(hStack)
        hStack.addArrangedSubview(spider_man_button)
        hStack.addArrangedSubview(dead_pool_button)
        hStack.addArrangedSubview(venom_button)
        
        NSLayoutConstraint.activate([
            hStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            hStack.heightAnchor.constraint(equalToConstant: 35),
            hStack.widthAnchor.constraint(equalToConstant: 350),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - Private methods
private extension MarverViewController {
    
    @objc private func spider_man_tapped() {
        print(ObjectIdentifier(self))
        
        dataBaseManager.obtainPosts(docId: .spider_man) { [weak self] results in
            switch results {
            case .success(let spider_man):
                self?.navigationItem.title = spider_man?.name
                self?.nameLabel.text = spider_man?.name ?? "no data"
                self?.descriptionLabel.text = spider_man?.description ?? "no data"
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        dataBaseManager.getImage(imageName: .spider_man) { [weak self] results in
            switch results {
            case .success(let spider_man):
                self?.heroImageView.image = spider_man
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func dead_pool_tapped() {
        print(ObjectIdentifier(self))
        
        dataBaseManager.obtainPosts(docId: .dead_pool) { [weak self] results in
            switch results {
            case .success(let dead_pool):
                self?.navigationItem.title = dead_pool?.name
                self?.nameLabel.text = dead_pool?.name ?? "no data"
                self?.descriptionLabel.text = dead_pool?.description ?? "no data"
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        dataBaseManager.getImage(imageName: .dead_pool) { [weak self] results in
            switch results {
            case .success(let dead_pool):
                self?.heroImageView.image = dead_pool
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func venom_tapped() {
        print(ObjectIdentifier(self))
        
        dataBaseManager.obtainPosts(docId: .venom) { [weak self] results in
            switch results {
            case .success(let venom):
                self?.navigationItem.title = venom?.name
                self?.nameLabel.text = venom?.name ?? "no data"
                self?.descriptionLabel.text = venom?.description ?? "no data"
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        dataBaseManager.getImage(imageName: .venom) { [weak self] results in
            switch results {
            case .success(let venom):
                self?.heroImageView.image = venom
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

