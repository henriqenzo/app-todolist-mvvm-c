//
//  HomeViewController.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()

    var viewModel: HomeViewModel!
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        navigationController?.navigationBar.isHidden = true
        homeView.delegate = self
        viewModel.delegate = self
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapPlusButton() {
        viewModel.didTapPlusButton(modalDelegate: self)
    }
    
    func didToggleTask(at index: Int) {
        viewModel.toggleTask(at: index)
    }
    
    func didDeleteTask(at index: Int) {
        viewModel.deleteTask(at: index)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdateItems() {
        homeView.updateItems(viewModel.items)
    }
}

extension HomeViewController: ModalVCDelegate {
    func didAddNewTask(title: String) {
        viewModel.addNewTask(title: title)
    }
}
