//
//  FeedViewController.swift
//  InstaFinal
//
//  Created by MacBook on 2/26/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "InstaFinal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutTapped))
        // Do any additional setup after loading the view.
    }
    @objc func signOutTapped() {
       try! Auth.auth().signOut()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
