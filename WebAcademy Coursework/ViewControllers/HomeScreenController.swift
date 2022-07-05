//
//  ViewController.swift
//  WebAcademy Coursework
//
//  Created by Dmytro Churakov on 22.06.2022.
//

import UIKit
import SDWebImage

class HomeScreenController: UIViewController {

    
    @IBOutlet weak var homescreenTableView: UITableView!
    
    let apiController = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiController.getUsers { (error) in
            if let error = error {
                print("Error of data task: \(error)")
            }
            DispatchQueue.main.async {
                self.homescreenTableView.reloadData()
            }
        }
        homescreenTableView.register(UINib(nibName: "HomeScreenPersonTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeScreenPersonTableViewCell")
    }
    
}

extension HomeScreenController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homescreenTableView.dequeueReusableCell(withIdentifier: "HomeScreenPersonTableViewCell", for: indexPath) as? HomeScreenPersonTableViewCell else { return UITableViewCell()}
        let user = apiController.users[indexPath.row]
        guard let imageData = try? Data(contentsOf: user.picture.medium) else { fatalError() }
        cell.nameLabel?.text = user.name.title + " " + user.name.first + " " + user.name.last
        cell.avatarImageView?.image = UIImage(data: imageData)
        return cell
    }
    
}

