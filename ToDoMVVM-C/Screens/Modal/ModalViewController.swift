//
//  ModalViewController.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

protocol ModalVCDelegate: AnyObject {
    func didAddNewTask(title: String)
}

class ModalViewController: UIViewController {
    
    weak var delegate: ModalVCDelegate?
    var viewModel: ModalViewModel!
    
    let modalView = ModalView()
    
    override func loadView() {
        view = modalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Modal"
        navigationController?.navigationBar.isHidden = true
        modalView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            viewModel.didFinish()
        }
    }

}

extension ModalViewController: ModalViewDelegate {
    func titleDidChange(_ sender: UITextField) {
        viewModel.updateItemTitle(text: sender.text)
    }
    
    func didTapAddButton() {
        guard viewModel.canAddNewTask() else { return }
        
        delegate?.didAddNewTask(title: viewModel.itemTitle)
        
        dismiss(animated: true, completion: nil)
    }
}
