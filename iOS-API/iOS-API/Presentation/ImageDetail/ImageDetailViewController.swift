//
//  ImageDetailViewController.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/28/25.
//

import UIKit
import Combine

// MARK: - ImageDetailViewController
class ImageDetailViewController: UIViewController {
    private let viewModel: ImageDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter filename"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - init
    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        bind()
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        view.addSubview(textField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    } // setupLayout
    
    // MARK: - bind
    private func bind() {
        viewModel.$filename
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.textField.text = name
            }
            .store(in: &cancellables)
    } // bind
    
    // MARK: - saveTapped
    @objc private func saveTapped() {
        guard let newName = textField.text, !newName.isEmpty else { return }
        Task {
            do {
                try await viewModel.updateImage(to: newName)
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            } catch {
                print("Update failed: \(error)")
            }
        }
    } // saveTapped
} // ImageDetailViewController
