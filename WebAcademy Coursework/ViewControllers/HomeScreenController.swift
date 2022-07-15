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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PersonInfoViewController", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PersonInfoViewController" {
            guard let personInfoVC = segue.destination as? PersonInfoViewController else { return }
            guard let indexPath = sender as? IndexPath else { return }
            let user = apiController.users[indexPath.row]
            personInfoVC.user = user
        }
    }
}

