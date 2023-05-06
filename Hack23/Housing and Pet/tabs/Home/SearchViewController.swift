//
//  SearchViewController.swift
//  ema88_p5
//
//  Created by Eman Abdu on 5/1/23.
//

import UIKit

class SearchViewController : UIViewController {
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    let cancel = UIButton()
    let reuseID = "my cell"

    
    let animals = ["Cat", "Dog", "Bunny"]
    var filterdata: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterdata = animals
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .white
        
        
        cancel.setTitle("Cancel", for: .normal)
        cancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cancel.setTitleColor(.black, for: .normal)
        cancel.addTarget(self, action: #selector(dismissSearchView), for: .touchUpInside)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancel)
        
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        searchBar.layer.borderWidth = 0.5
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.layer.borderColor = UIColor.black.cgColor
        
//        searchBar.showsBookmarkButton = true
        
        view.addSubview(searchBar)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        setupConstraints()
        
        
    }
    
    @objc func dismissSearchView() {
        dismiss(animated: false, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cancel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            cancel.leadingAnchor.constraint(equalTo: view.trailingAnchor,constant: -100),
            cancel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancel.heightAnchor.constraint(equalToConstant: 40)
//            cancel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.topAnchor.constraint(equalTo: cancel.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: cancel.leadingAnchor, constant: -5),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: cancel.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension SearchViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Yay")
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = filterdata[indexPath.row]
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate
{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filterdata = []
    if searchText == ""
    {
      filterdata = animals
    }

    for word in animals
    {
      if word.uppercased().contains(searchText.uppercased())
      {
        filterdata.append(word)
      }
    }
    self.tableView.reloadData()
  }
}
