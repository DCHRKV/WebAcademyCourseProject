//
//  PersonInfoViewController.swift
//  WebAcademy Coursework
//
//  Created by Dmytro Churakov on 15.07.2022.
//

import UIKit
import SDWebImage

class PersonInfoViewController: UIViewController {
    
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    @IBOutlet weak var personInfoAvatarImageView: UIImageView!
    @IBOutlet weak var personInfoFullNameLabel: UILabel!
    @IBOutlet weak var personInfoGenderLabel: UILabel!
    @IBOutlet weak var personInfoDobLabel: UILabel!
    @IBOutlet weak var personInfoPhoneNumberView: UILabel!
    @IBOutlet weak var personInfoEmailLabel: UILabel!
    
    
    private func getDateFormat(input: String) -> String {
        return input.count > 9 ? String(input.prefix(10)) : ""
        
    }
    
    func updateViews() {
        guard isViewLoaded,
              let user = user else { return }
        title = user.name.first
        personInfoFullNameLabel.text = user.name.title + " " + user.name.first + " " + user.name.last
        personInfoGenderLabel.text = user.gender
        personInfoDobLabel.text = getDateFormat(input: user.dob.date)
        personInfoPhoneNumberView.text = user.phone
        guard let imageData = try? Data(contentsOf: user.picture.large) else { fatalError() }
        personInfoAvatarImageView.image = UIImage(data: imageData)
        personInfoEmailLabel.text = user.email
    }
    
}
