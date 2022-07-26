//
//  HomeScreenPersonTableViewCell.swift
//  WebAcademy Coursework
//
//  Created by Dmytro Churakov on 03.07.2022.
//

import UIKit
import SDWebImage

class HomeScreenPersonTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(user:User) {
        guard let imageData = try? Data(contentsOf: user.picture.medium) else { fatalError() }
        nameLabel?.text = user.name.title + " " + user.name.first + " " + user.name.last
        avatarImageView?.image = UIImage(data: imageData)
    }
}
