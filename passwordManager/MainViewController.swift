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
        
        // do not make first responder either one of the text fields
        self.domainTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        passwords = passwordDB.instance.getPassword()
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        passwordsTableView.dataSource = self
//        passwordsTableView.delegate = self
//    }
//
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        domainTextField.text = passwords[indexPath.row].domain
        passwordTextField.text = passwords[indexPath.row].password
        
        selectedPassword = indexPath.row
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordTableViewCell
        
        cell.myFirstCellLabel.text = passwords[indexPath.row].domain
        cell.mySecondCellLabel.text = passwords[indexPath.row].password
        
        return cell
    }
    
    
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
            let id = passwords[selectedPassword!].id!
            
            passwords.remove(at: selectedPassword!)
            
            passwordDB.instance.deletePassword(cid: id)
            
            passwordsTableView.deleteRows(at: [NSIndexPath(row: selectedPassword!, section: 0) as IndexPath], with: .fade)
        } else {
            print("No item selected")
        }
    }
    
}
