//
//  RickMortyViewController.swift
//  RickandMortyMvvm
//
//  Created by Pınar Macit on 14.05.2022.
//

import UIKit
import SnapKit
protocol RickMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(value: [Result])
}

final class RickMortyViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickMortyViewModel = RickMortyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegete(output: self)
        viewModel.fetchItems()
        
    }
    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesing()
        makeTableView()
        makeLabel()
        makeIndicator()
    }
   private func drawDesing() {
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
       tableView.rowHeight = 150
       DispatchQueue.main.async {
           self.view.backgroundColor = .white
           self.labelTitle.font = .boldSystemFont(ofSize: 25)
           self.indicator.color = .red
           self.labelTitle.text = "Rick and Morty"
       }
       indicator.startAnimating()
    }
}
extension RickMortyViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    
}
extension RickMortyViewController: RickMortyOutput{
    func saveDatas(value: [Result]) {
        results = value
        tableView.reloadData()
    }
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
}

extension RickMortyViewController {
    
    private func makeTableView() {
    tableView.snp.makeConstraints{(make) in
       make.top.equalTo(labelTitle.snp.bottom).offset(5)
       make.bottom.equalToSuperview()
       make.left.right.equalTo(labelTitle)
   }
}
    private func makeLabel(){
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(35)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    func makeIndicator(){
        indicator.snp.makeConstraints{(make) in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}
