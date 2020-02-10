//
//  ViewController.swift
//  InfiniteSol
//
//  Created by Chandra Rao on 08/02/20.
//  Copyright © 2020 Chandra Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrUserData: [Results]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Random Users"
        
        CustomLoader.sharedInstance.addLoader(onView: self.view)
        APIManager.sharedInstance.conformToUsersProtocol(withDelegate: self)
        APIManager.sharedInstance.callGetUsersApi(withCount: "50")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let usersData = self.arrUserData {
            return usersData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell {
            if let usersData = self.arrUserData {
                cell.configureView(withData: usersData[indexPath.row], forIndexPath: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let usersData = self.arrUserData {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
            detailsVC.userData = usersData[indexPath.row]
            detailsVC.userImageURL = usersData[indexPath.row].picture?.large ?? ""
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension ViewController: UsersProtocol {
    func didReceiveUsersResponse(withData usersData: UserList?, withError error: Error?) {
        DispatchQueue.main.async {
            CustomLoader.sharedInstance.removeLoader()
            if let data = usersData {
                if let users = data.results, users.count > 0 {
                    self.arrUserData = users
                }
                self.tableView.reloadData()
            }
        }
    }
    
}
