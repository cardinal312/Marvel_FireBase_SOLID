//
//  ViewController.swift
//  MarvelFireBase
//
//  Created by Macbook on 8/12/23.
//

import UIKit

final class MarvelViewController: UIViewController {
    
    //MARK: - Veriables
    private var dataBaseManager: DataBaseManagerProtocol
    private var uiManager: UIManagerFactoryProtocol
    private var coreDataManager: CoreDataManagerProtocol
    
    //MARK: - UI Components
    private var heroImageView: UIImageView
    private var nameLabel: UILabel
    private let descriptionLabel: UILabel
    private let vStack: UIStackView
    private let spider_man_button: UIButton
    private let dead_pool_button: UIButton
    private let venom_button: UIButton
    private let hStack: UIStackView
    private let spinner: UIActivityIndicatorView
    
    //MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dataBaseManager = dependencies.dataBaseManager
        self.uiManager = dependencies.uiManagerFactory
        self.coreDataManager = dependencies.coreDataManager
        
        self.heroImageView = uiManager.heroImageView()
        self.nameLabel = uiManager.nameLabel()
        self.descriptionLabel = uiManager.descriptionLabel()
        self.vStack = uiManager.buildStack(axis: .vertical, spacing: 5)
        self.spider_man_button = uiManager.spider_man_button()
        self.dead_pool_button = uiManager.dead_pool_button()
        self.venom_button = uiManager.venom_button()
        self.hStack = uiManager.buildStack(axis: .horizontal, spacing: 5)
        self.spinner = uiManager.spinner()
        
        super.init(nibName: nil, bundle: nil)
        
        let coreImage = coreDataManager.heroItemCopy.compactMap { $0.heroImage }
        self.heroImageView.image = UIImage(data: coreImage.last ?? Data())
        
        let coreName = coreDataManager.heroItemCopy.compactMap { $0.name }
        self.nameLabel.text = coreName.last
        
        let coreDesc = coreDataManager.heroItemCopy.compactMap { $0.heroDesc }
        self.descriptionLabel.text = coreDesc.last
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confifureUI()
        self.spider_man_button.addTarget(self, action: #selector(spider_man_tapped), for: .touchUpInside)
        self.dead_pool_button.addTarget(self, action: #selector(dead_pool_tapped), for: .touchUpInside)
        self.venom_button.addTarget(self, action: #selector(venom_tapped), for: .touchUpInside)
    }
}

// MARK: - Private methods
private extension MarvelViewController {
    
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
        
        self.spinner.startAnimating()
        dataBaseManager.getImage(imageName: .spider_man) { [weak self] results in
            switch results {
            case .success(let spider_man):
                DispatchQueue.main.async {
                    self?.heroImageView.image = spider_man
                    self?.spinner.stopAnimating()
                }
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
        
        self.spinner.startAnimating()
        dataBaseManager.getImage(imageName: .dead_pool) { [weak self] results in
            switch results {
            case .success(let dead_pool):
                DispatchQueue.main.async {
                    self?.heroImageView.image = dead_pool
                    self?.spinner.stopAnimating()
                }
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
        
        self.spinner.startAnimating()
        dataBaseManager.getImage(imageName: .venom) { [weak self] results in
            switch results {
            case .success(let venom):
                DispatchQueue.main.async {
                    self?.heroImageView.image = venom
                    self?.spinner.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - Setup constraints
    private func confifureUI() {
        
        view.addSubview(heroImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(vStack)
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(descriptionLabel)
        
        view.addSubview(spider_man_button)
        view.addSubview(dead_pool_button)
        view.addSubview(venom_button)
        view.addSubview(spinner)
        
        view.addSubview(hStack)
        hStack.addArrangedSubview(spider_man_button)
        hStack.addArrangedSubview(dead_pool_button)
        hStack.addArrangedSubview(venom_button)
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heroImageView.heightAnchor.constraint(equalToConstant: 300),
            heroImageView.widthAnchor.constraint(equalToConstant: 300),
            heroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            vStack.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 10),
            vStack.heightAnchor.constraint(equalToConstant: 100),
            vStack.widthAnchor.constraint(equalToConstant: 300),
            vStack.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor),
            
            hStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            hStack.heightAnchor.constraint(equalToConstant: 35),
            hStack.widthAnchor.constraint(equalToConstant: 350),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spinner.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 40),
            spinner.heightAnchor.constraint(equalToConstant: 70),
            spinner.widthAnchor.constraint(equalToConstant: 70),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

