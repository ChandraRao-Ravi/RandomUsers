//
//  UsersTableViewCell.swift
//  InfiniteSol
//
//  Created by Chandra Rao on 10/02/20.
//  Copyright © 2020 Chandra Rao. All rights reserved.
//

import UIKit
import SDWebImage

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureView(withData userData: Results?, forIndexPath indexPath: IndexPath?) {
        if let user = userData {
            
            DispatchQueue.main.async {
                self.innerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
                self.userImage.makeRoundedCorners(withCornerRadius: self.userImage.frame.size.width / 2)
            }
            
            self.userName.text = "Name : \(user.name?.getUserName() ?? "")"
            self.userAge.text = "Age : \(user.dob?.getUserAge() ?? "")"
            self.userEmail.text = "E-Mail : \(user.email ?? "")"
            
            if let imgName = user.picture?.thumbnail {
                self.userImage.sd_setImage(with: URL(string: imgName), placeholderImage: UIImage(named: "userIMG"), options: .refreshCached) { (image, error, cacheType, url) in
                    
                }
            }
        }
    }
}

extension UIView {
    
    func makeRoundedCorners(withCornerRadius cornerRadius: CGFloat?) {
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
