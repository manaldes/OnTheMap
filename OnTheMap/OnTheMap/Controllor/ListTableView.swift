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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParseClient.studentLocations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        let student = ( ParseClient.studentLocations?[indexPath.row])!
        cell.nameLabel.text = student.mapString
        cell.mediaUrl.text = student.mediaURL
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = (ParseClient.studentLocations?[indexPath.row])?.mediaURL {
       
            let url = URL(string : link)
        
        if url != nil {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
        
    }
    
    
}
