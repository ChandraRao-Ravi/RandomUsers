//
//  UserDetailsViewController.swift
//  InfiniteSol
//
//  Created by Chandra Rao on 10/02/20.
//  Copyright © 2020 Chandra Rao. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userData: Results?
    var userImageURL: String?
    
    var arrUserDetails: [[String: Any]]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    func setUpUI() {
        DispatchQueue.main.async {
            if let userDetails = self.userData {
                self.arrUserDetails?.append([
                    "Value": "Name : \(userDetails.name?.getFullUserName() ?? "")"
                    ])
                self.arrUserDetails?.append([
                    "Value": "E-Mail : \(userDetails.email ?? "")"
                    ])
                self.arrUserDetails?.append([
                    "Value": "Phone : \(userDetails.phone ?? "")"
                    ])
                self.arrUserDetails?.append([
                    "Value": "Gender : \(userDetails.gender ?? "")"
                    ])
                self.arrUserDetails?.append([
                    "Value": "Date Of Birth : \(userDetails.dob?.getDateOfBirth() ?? "")"
                    ])
                self.arrUserDetails?.append([
                    "Value": "Location : \(userDetails.location?.getLocation() ?? "")"
                    ])
                
                self.tableView.reloadData()
            }
        }
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let usersData = self.arrUserDetails {
            return usersData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        viewHeader.addSubview(imageView)
        imageView.center = viewHeader.center
        
        imageView.makeRoundedCorners(withCornerRadius: imageView.frame.size.width / 2)
        
        if let url = self.userImageURL {
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "userIMG"), options: .refreshCached) { (image, error, cacheType, url) in
                
            }
        }
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") as? UITableViewCell {
            if let usersData = self.arrUserDetails {
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = usersData[indexPath.row]["Value"] as? String ?? ""
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
