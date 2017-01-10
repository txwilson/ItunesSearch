//
//  ViewController3.swift
//  WilsonTylerAssignment3
//
//  Created by Tyler Wilson on 10/20/16.
//  Copyright © 2016 Tyler Wilson. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var info: [String] = []
    
    func getJsonInfo(array: [String]){
        print("ARRAY \(array)")
        info = array
    }
   
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int)-> Int {
        return self.info.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!)-> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: "cell")
        cell.textLabel?.text = info[indexPath.row]
        return cell
    }
    
    @IBAction func newSearch(_ sender: AnyObject) {
        
    }
    
}
