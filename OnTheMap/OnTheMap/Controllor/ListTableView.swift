//
//  ListTableView.swift
//  OnTheMap
//
//  Created by Manal  harbi on 09/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit

class ListTableView : UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    
    
    @IBOutlet weak var tableView : UITableView!

    var result = [GetStudentLocation]()
    
    //var studentLocation:[GetStudentLocation]! {
     //   return Global.shared.studentLocation
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        result = GetStudentLocation.lastFetched ?? []
        
        print("enter table ")
    }
    
  
    @IBAction func refreshButton(_ sender: Any) {
      reloadStudentLocation()
    }
    
    
    @IBAction func AddPinButton(_ sender: Any) {
        self.performSegue(withIdentifier: "AddSeque2", sender: nil)
    }
 
    @IBAction func Logout(_ sender: Any) {
        UdasityClient.DeleteSession { (error) in
            
            guard error != nil else {
                
                Global.showeAlert(viewController: self, title: "Ther is an error to logout ", message: "")
                return
            }
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
            }
            }
            
        }  // end logout
    
    
    
    func reloadStudentLocation () {
     
        ParseClient.getLocations  { (  result , error ) in
            
            guard error == nil else {
                print(" There is an error ")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
         }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! TableViewCell
        let student = self.result[(indexPath).row]
    
        
        let firstName = result[indexPath.row].firstName
            
        
        //let firstName = (GetStudentLocation.lastFetched?[indexPath.row])?.firstName
        let lastName = result[indexPath.row].lastName
        
        cell.nameLabel.text = "\(firstName) \(lastName)"
        
        cell.mediaUrl.text = student.mediaURL
        
         
            
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = (Global.shared.studentLocation?[indexPath.row])?.mediaURL {
       
            let url = URL(string : link)
        
        if url != nil {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
        
    }
    
}
    


