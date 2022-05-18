//
//  ViewController.swift
//  Assignment7_NavgationBarAnimation
//
//  Created by Tomonao Hashiguchi on 2022-05-17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var navBar: UIView!
    @IBOutlet var heightOfNavBar: NSLayoutConstraint!
    @IBOutlet var mainTableView: UITableView!
    
    var stackView = UIStackView()
    var navBarTitileLabel: UILabel = {
        let label = UILabel()
        label.text = "SNACKS"
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let navBarOptions = ["oreos", "pizza_pockets", "pop_tarts", "popsicle", "ramen"]
    var tappedItems: [String] = ["tap plus", "tap a item", "you can see the name of item"]
    var isNavBarOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupStackView()
        mainTableView.dataSource = self
    }
    func setupNavBar(){
        navBar.addSubview(navBarTitileLabel)
        navBarTitileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBarTitileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
    }
    func setupStackView(){
        let navBarOptionsObjectForDisplay: [UIImageView] = navBarOptions.map{(nameOfItem) -> UIImageView in
            let imgView = UIImageView(image: UIImage(named: nameOfItem))
            imgView.restorationIdentifier = nameOfItem
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addItemOnTable(tapGestureRecognize:))))
            return imgView
        }
        for displayObject in navBarOptionsObjectForDisplay{
            stackView.addArrangedSubview(displayObject)
        }

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        navBar.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.isHidden = true
    }
    
    @IBAction func plusIconPressed(_ sender: UIButton) {
        sender.isEnabled = false
        isNavBarOpen.toggle()
        stackView.isHidden = !isNavBarOpen
        
        self.heightOfNavBar.constant = isNavBarOpen ? 200 : 88
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2) {
            self.view.layoutIfNeeded()
            if self.isNavBarOpen {
                sender.transform = CGAffineTransform(rotationAngle: .pi/4)
            } else {
                sender.transform = .identity
            }
        } completion: { _ in
            sender.isEnabled = true
        }
    }
    
    @objc func addItemOnTable(tapGestureRecognize: UITapGestureRecognizer){
        let tappedItem = tapGestureRecognize.view as! UIImageView
        tappedItems.insert(tappedItem.restorationIdentifier!, at: 0)
        mainTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tappedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") ?? UITableViewCell(style: .default, reuseIdentifier: "itemCell")
        cell.textLabel?.text = tappedItems[indexPath.row]
        return cell
    }
    
}

