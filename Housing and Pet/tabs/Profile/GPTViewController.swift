//
//  GPTViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/5/23.
//

import UIKit

class GPTViewController: UIViewController {
    
    let gptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Ubuntu-Regular", size: 24)
        label.text = "Your personal GPT4!!!\n(it's 4 not 3.5)"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ChatgptTableViewCell.self, forCellReuseIdentifier: ChatgptTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    let prompTextView: UITextView = {
        let textfield = UITextView()
        textfield.font = UIFont(name: "Ubuntu-Medium", size: 14)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocapitalizationType = .none
//        textfield.leftViewMode = .always
//        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.autocorrectionType = .no
        textfield.layer.cornerRadius = 10
        textfield.clipsToBounds = true
        textfield.backgroundColor = .systemGray6
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.secondaryLabel.cgColor
        textfield.returnKeyType = .done
//        textfield.placeholder = "Please Enter A Prompt"
//        textfield.contentVerticalAlignment = .top
        return textfield
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        return button
    }()
    
    var chat = [String]()
    let indicatorView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        

        configureUi()
        
    }
    
    private func configureUi(){
        view.addSubview(gptLabel)
        view.addSubview(tableView)
        view.addSubview(prompTextView)
        view.addSubview(submitButton)
        view.addSubview(indicatorView)
        
        indicatorView.isHidden = true
        indicatorView.frame = view.bounds
        indicatorView.backgroundColor = .systemGray6
        indicatorView.alpha = 0.95
        
        indicatorView.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            gptLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            gptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gptLabel.widthAnchor.constraint(equalToConstant: 300),
            gptLabel.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: gptLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: 400),
            
            prompTextView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            prompTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            prompTextView.widthAnchor.constraint(equalToConstant: 300),
            prompTextView.heightAnchor.constraint(equalToConstant: 100),
            
            submitButton.topAnchor.constraint(equalTo: prompTextView.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 300),
            submitButton.heightAnchor.constraint(equalToConstant: 60),
        
        ])
    }
    
    private func fetchGPTChatResponse(prompt: String){
        indicatorView.isHidden = false
        activityIndicator.startAnimating()
        Task{
            do{
                let gptText = try await APIService().sendPromptToGPT(prompt: prompt)
                await MainActor.run{
                    print(gptText)
                    indicatorView.isHidden = true
                    activityIndicator.stopAnimating()
                    chat.append(prompt)
                    chat.append(gptText.replacingOccurrences(of: "\n\n", with: ""))
                    tableView.reloadData()
                    tableView.scrollToRow(at: IndexPath(row: chat.count-1, section: 0), at: .bottom, animated: true)
                    prompTextView.text = ""

                }
            }catch{
                indicatorView.isHidden = true
                activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc func didTapSubmit(){
        prompTextView.resignFirstResponder()
        if let promptText = prompTextView.text, promptText.count > 3 {
            fetchGPTChatResponse(prompt: promptText)
        } else {
            print("please check textfield")
        }
    }
}

extension GPTViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatgptTableViewCell.identifier, for: indexPath) as! ChatgptTableViewCell
        let text = chat[indexPath.row]
        print(chat)

        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        if indexPath.row % 2 == 0{
            cell.configure(text: text, isUser: true)
        }else{
            cell.configure(text: text, isUser: false)
        }
        return cell
    }
    
    
}
