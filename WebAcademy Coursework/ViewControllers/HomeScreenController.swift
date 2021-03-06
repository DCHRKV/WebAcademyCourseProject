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
    
    private let personInfoVC_ID = "PersonInfoViewController"
    private let homeScreenPersonTableViewCell = "HomeScreenPersonTableViewCell"
    private var users = [User]()
    private let apiController = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        homescreenTableView.register(UINib(nibName: homeScreenPersonTableViewCell, bundle: nil), forCellReuseIdentifier: homeScreenPersonTableViewCell)
    }
    
    private func getUsers() {
        apiController.getUsers { [weak self] newUsers in
            guard let self = self else { return }
            
            self.users += newUsers
            
            DispatchQueue.main.async {
                self.homescreenTableView.reloadData()
            }
        }
    }
}

extension HomeScreenController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homescreenTableView.dequeueReusableCell(withIdentifier: homeScreenPersonTableViewCell, for: indexPath) as? HomeScreenPersonTableViewCell else { return UITableViewCell() }
        let user = users[indexPath.row]
        cell.setup(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: personInfoVC_ID, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == users.count - 3 {
            getUsers()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == personInfoVC_ID {
            guard let personInfoVC = segue.destination as? PersonInfoViewController, let indexPath = sender as? IndexPath else { return }
            let user = users[indexPath.row]
            personInfoVC.user = user
        }
    }
}

