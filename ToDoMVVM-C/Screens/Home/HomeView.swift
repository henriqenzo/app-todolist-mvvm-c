//
//  HomeView.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapPlusButton()
    func didToggleTask(at index: Int)
    func didDeleteTask(at index: Int)
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    private var items: [TodoItem] = []
    
    private let titleLabel = UILabel()
    private let plusButton = UIButton()
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [titleLabel, plusButton, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        titleLabel.text = "Lista de tarefas"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let largeImage = UIImage(systemName: "plus", withConfiguration: largeConfig)
        plusButton.setImage(largeImage, for: .normal)
        plusButton.tintColor = .white
        plusButton.backgroundColor = .systemBlue
        plusButton.layer.cornerRadius = 25
        plusButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.identifier)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            
            plusButton.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            plusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func didTapButton() {
        delegate?.didTapPlusButton()
    }
    
    func updateItems(_ items: [TodoItem]) {
        self.items = items
        tableView.reloadData()
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _  in
            self?.delegate?.didDeleteTask(at: indexPath.row)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension HomeView: ItemCellDelegate {
    func didTapCheckmark(on cell: ItemCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        delegate?.didToggleTask(at: indexPath.row)
    }
}
