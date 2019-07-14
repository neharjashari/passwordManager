//
//  MainViewController.swift
//  passwordManager
//
//  Created by Nehar Jashari on 7/13/19.
//  Copyright © 2019 Nehar Jashari. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Build in function for removing the keyboard after you click away from it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBOutlet weak var domainTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordsTableView: UITableView!
    
    private var passwords = [Passwords]()
    private var selectedPassword: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        passwordsTableView.dataSource = self
        passwordsTableView.delegate = self
        
        passwords = passwordDB.instance.getPassword()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        domainTextField.text = passwords[indexPath.row].domain
        passwordTextField.text = passwords[indexPath.row].password
        
        selectedPassword = indexPath.row
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath)
        
        var label: UILabel
        
        label = cell.viewWithTag(1) as! UILabel // Domain label
        label.text = passwords[indexPath.row].domain
        
        label = cell.viewWithTag(2) as! UILabel // Password label
        label.text = passwords[indexPath.row].password
        
        return cell
    }
    
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell")!
        var label: UILabel
        label = cell.viewWithTag(1) as! UILabel // Name label
        label.text = passwords[indexPath.row].domain
        
        label = cell.viewWithTag(2) as! UILabel // Phone label
        label.text = passwords[indexPath.row].password
        
        return cell
    }
    */
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let domainVal = domainTextField.text ?? ""
        let passwordVal = passwordTextField.text ?? ""
        
        if let id = passwordDB.instance.addPassword(cdomain: domainVal, cpassword: passwordVal) {
            
            let password = Passwords(id: 0, domain: domainVal, password: passwordVal)
            passwords.append(password)
            passwordsTableView.insertRows(at: [NSIndexPath(row: passwords.count-1, section: 0) as IndexPath], with: .fade)
        }
    }
    
    @IBAction func updateButtonClick(_ sender: UIButton) {
        if selectedPassword != nil {
            let id = passwords[selectedPassword!].id!
            let password = Passwords(
                id: id,
                domain: domainTextField.text ?? "",
                password: passwordTextField.text ?? "")
            
            _ = passwordDB.instance.updatePassword(cid: id, newPassword: password)
            
            passwords.remove(at: selectedPassword!)
            passwords.insert(password, at: selectedPassword!)
            
            passwordsTableView.reloadData()
        } else {
            print("No item selected")
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        if selectedPassword != nil {
            passwords.remove(at: selectedPassword!)
            
            _ = passwordDB.instance.deletePassword(cid: passwords[selectedPassword!].id!)
            
            passwordsTableView.deleteRows(at: [NSIndexPath(row: selectedPassword!, section: 0) as IndexPath], with: .fade)
        } else {
            print("No item selected")
        }
    }
    
}
