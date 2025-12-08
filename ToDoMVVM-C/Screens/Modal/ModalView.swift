//
//  ModalView.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

protocol ModalViewDelegate: AnyObject {
    func titleDidChange(_ sender: UITextField)
    func didTapAddButton()
}

class ModalView: UIView {
    
    weak var delegate: ModalViewDelegate?
    
    private let titleLabel = UILabel()
    private let titleTextField = UITextField()
    private let addButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [titleTextField, addButton])
        stack.axis = .vertical
        stack.spacing = 32
        
        [titleLabel, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        titleLabel.text = "Adicionar tarefa"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Digite o título da tarefa",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        titleTextField.backgroundColor = .white
        titleTextField.textColor = .black
        titleTextField.layer.cornerRadius = 8
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.systemGray.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        titleTextField.leftView = paddingView
        titleTextField.rightView = paddingView
        titleTextField.leftViewMode = .always
        titleTextField.rightViewMode = .always
        titleTextField.autocapitalizationType = .none
        titleTextField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
        
        addButton.setTitle("Adicionar", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 8
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func titleChanged() {
        delegate?.titleDidChange(titleTextField)
    }
    
    @objc func addButtonTapped() {
        delegate?.didTapAddButton()
    }

}
