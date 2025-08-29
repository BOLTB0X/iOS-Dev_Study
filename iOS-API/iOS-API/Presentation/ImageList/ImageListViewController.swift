//
//  ViewController.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/18/25.
//

import UIKit
import Combine

// MARK: - ImageListViewController
final class ImageListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel: ImageListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ImageListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "우려먹기"
        view.backgroundColor = .systemBackground
        
        setupTableView()
        bindViewModel()
        loadImages()
    } // viewDidLoad
    
    // MARK: - setupTableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.rowHeight = 300
    } // setupTableView
    
    // MARK: - bindViewModel
    private func bindViewModel() {
        viewModel.$images
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { isLoading in
                if isLoading {
                    LoadingIndicator.show()
                } else {
                    LoadingIndicator.hide()
                }
            }
            .store(in: &cancellables)
        
    } // bindViewModel
    
    // MARK: - loadImages
    private func loadImages() {
        Task {
            await viewModel.fetchImages()
        }
    } // loadImages
} // ImageListViewController

// MARK: - Delegate
// ....

// MARK: - UITableViewDataSource
extension ImageListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier,
                                                       for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }
        let image = viewModel.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
} // UITableViewDataSource

// MARK: - UITableViewDelegate
extension ImageListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = viewModel.images[indexPath.row]
        let detailVM = ImageDetailViewModel(image: image, useCase: viewModel.updateUseCase)

        detailVM.didUpdate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updated in
                self?.viewModel.updateImageInList(updated)
            }
            .store(in: &cancellables)
        
        let detailVC = ImageDetailViewController(viewModel: detailVM)
        present(detailVC, animated: true)
    } // tableView
    
} // UITableViewDelegate

// MARK: - ViewController_Preview
//#if DEBUG
//import SwiftUI
//
//struct ViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        ImageListViewController().toPreview()
//    }
//}
//#endif
