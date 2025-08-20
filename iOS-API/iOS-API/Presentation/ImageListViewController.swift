//
//  ViewController.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/18/25.
//

import UIKit

// MARK: - ImageListViewController
final class ImageListViewController: UIViewController {
    private let tableView = UITableView()
    private let items: [String] = [
        "첫 번째 셀",
        "두 번째 셀",
        "세 번째 셀",
        "네 번째 셀"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "리스트 화면"
        view.backgroundColor = .systemBackground
        
        setupTableView()
    }
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
} // ImageListViewController

// MARK: - Delegate
// ....

// MARK: - UITableViewDataSource
extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
} // UITableViewDataSource

// MARK: - UITableViewDelegate
extension ImageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("터치: \(items[indexPath.row])")
    }
} // UITableViewDelegate

// MARK: - ViewController_Preview
#if DEBUG
import SwiftUI

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ImageListViewController().toPreview()
    }
}
#endif
