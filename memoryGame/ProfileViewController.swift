//
//  ProfileViewController.swift
//  memoryGame
//
//  Created by Ani on 11/8/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var scrollLabel: UILabel!
    
    var observation: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = UIImage(named: "photo")
        userNameLabel.text = UserModel.shared.userName
        scrollLabel.text = "\(UserModel.shared.score)"
        
        observation = UserModel.shared.observe(\.score, options: [.new]) { [weak self] (user, change) in
            if let self = self, let newValue = change.newValue {
                print("Called \(user.score)")
                self.scrollLabel.text = "Score: " + String(newValue)
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logOut),
                                               name: .logOutSuccess,
                                               object: nil)
        
    }
    
    @objc func logOut(note: Notification) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func moreButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title: nil, message: "Choose Options", preferredStyle: .actionSheet)
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)
        actionsheet.addAction(cancelActionButton)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive, handler: {(notification) in NotificationCenter.default.post(name: .logOutSuccess, object: nil)})
        
        actionsheet.addAction(logOutAction)
        self.present(actionsheet, animated: true, completion: nil)
    }
}

extension NSNotification.Name {
    public static let logOutSuccess = NSNotification.Name.init("logOutSuccess")
}
