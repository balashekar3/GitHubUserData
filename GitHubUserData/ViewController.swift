//
//  ViewController.swift
//  GitHubUserData
//
//  Created by apple on 05/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var gitImg: UIImageView!
    @IBOutlet weak var userNameTF: UITextField!
    
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userLogin: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userRepos: UILabel!
    
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userCreated: UILabel!
    @IBOutlet weak var userUpdated: UILabel!
    @IBOutlet weak var userNode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelStatus(value: true)
    }

    @IBAction func showBT(_ sender: UIButton) {
        fetchData()
    }
    
    func setLabelStatus(value: Bool) {
        userLogin.isHidden = value
        userBio.isHidden = value
        userRepos.isHidden = value
        userID.isHidden = value
        gitImg.isHidden = value
        userLogin.isHidden=value
        userCreated.isHidden=value
        userUpdated.isHidden=value
        userNode.isHidden=value
        
        
    }
    
    func fetchData(){
        let userText = userNameTF.text?.lowercased()
        
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText!) else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(GitUser.self, from: data)
                if error == nil{
                    if let userName=gitData.login{
                        self.showAlert(title: "Booyaah!!", msg: "Hey my valuable user\n" + userName + "Welcome to Git Hub.\n")
                    }
                }else if error != nil {
                    self.showAlert(title: "Error", msg: "Something went worng please check the username")
                }
                
                
               
                DispatchQueue.main.sync {
                    if let gimage = gitData.avatar_url {
                        let data = try? Data(contentsOf: gimage)
                        let image: UIImage = UIImage(data: data!)!
                        self.gitImg.image = image
                    }
                    
                    
                    if let gID = gitData.id {
                        self.userID.text = String(gID)
                    }
                    if let glogin=gitData.login{
                        self.userLogin.text=glogin
                    }
                    if let gbio=gitData.bio{
                        self.userBio.text=gbio
                    }
                    if let glocation=gitData.location{
                        self.userLocation.text=glocation
                        
                    }
                    if let gtype=gitData.type{
                        self.userType.text=gtype
                        
                    }
                    if let gcreated=gitData.created_at{
                        self.userCreated.text=gcreated
                        
                    }
                    if let gUpdated=gitData.updated_at{
                        self.userUpdated.text=gUpdated
                    }
                    if let gnode=gitData.node_id{
                        self.userNode.text=gnode
                    }
                    if let grepos = gitData.public_repos {
                        self.userRepos.text = String(grepos)
                    }
                    self.setLabelStatus(value: false)
                }
                
            } catch {
                self.showAlert(title: "Error", msg: "Not found any git account with your name please check username")
                print(error.localizedDescription)
            }
        }.resume()

}

}
extension UIViewController {
    func showAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            

            self.present(alert, animated: true, completion: nil)
        }
    }
}

