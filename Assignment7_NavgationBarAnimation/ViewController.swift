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
    
    var isNavBarOpen = false
    
    var stackView: UIStackView = {
        let imgView1 = UIImageView(image: UIImage(named: "oreos"))
        let imgView2 = UIImageView(image: UIImage(named: "pizza_pockets"))
        let imgView3 = UIImageView(image: UIImage(named: "pop_tarts"))
        let imgView4 = UIImageView(image: UIImage(named: "popsicle"))
        let imgView5 = UIImageView(image: UIImage(named: "ramen"))
        
        let stackView = UIStackView(arrangedSubviews: [imgView1, imgView2, imgView3, imgView4, imgView5])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStackView()
        setupTableView()
    }
    
    func setupStackView(){
        navBar.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.isHidden = true
    }
    func setupTableView(){
        
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
}

