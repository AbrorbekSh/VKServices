//
//  ViewController.swift
//  ServicesInfo
//
//  Created by Аброрбек on 31.03.2024.
//

import UIKit

final class ServicesViewController: UIViewController {
    private let viewModel: ServicesViewModel
    
    init(viewModel: ServicesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let servicesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сервисы"
        
        setupTableView()
        fetchServices()
    }

    private func setupTableView() {
        servicesTableView.dataSource = self
        servicesTableView.delegate = self
        
        view.addSubview(servicesTableView)
        
        NSLayoutConstraint.activate([
            servicesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            servicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            servicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            servicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchServices() {
        viewModel.fetchServices { [weak self] error in
            guard let self, error == nil else { return }
            DispatchQueue.main.async {
                self.servicesTableView.reloadData()
            }
        }
    }
}

extension ServicesViewController:  UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfServices()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as! ServiceTableViewCell
        viewModel.configure(cell: cell, at: indexPath.row)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectService(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
