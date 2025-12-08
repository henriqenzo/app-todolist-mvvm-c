//
//  ItemCell.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

protocol ItemCellDelegate: AnyObject {
    func didTapCheckmark(on cell: ItemCell)
}

class ItemCell: UITableViewCell {
    
    static let identifier = "TaskCell"
    
    weak var delegate: ItemCellDelegate?
    
    let checkmarkImageView = UIImageView()
    let taskTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupCheckmarkTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [checkmarkImageView, taskTitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        backgroundColor = .white
        selectionStyle = .none
        
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.tintColor = .systemBlue
        taskTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        taskTitleLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            checkmarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            
            taskTitleLabel.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 12),
            taskTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupCheckmarkTap() {
        checkmarkImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkmarkTapped))
        checkmarkImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func checkmarkTapped() {
        delegate?.didTapCheckmark(on: self)
    }
    
    func configure(with item: TodoItem) {
        taskTitleLabel.text = item.title
        
        let imageName = item.isCompleted ? "checkmark.circle.fill" : "circle"
        checkmarkImageView.image = UIImage(systemName: imageName)
    }
}
