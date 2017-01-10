//
//  ViewController.swift
//  WilsonTylerAssignment3
//
//  Created by Tyler Wilson on 10/16/16.
//  Copyright © 2016 Tyler Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var selectedCategory: String = ""
    
    override func viewDidLoad() {
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let choices = ["Audio and Video","Movie","Software "]
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int)-> Int {
        return self.choices.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!)-> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: "cell")
        cell.textLabel?.text = choices[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        selectedCat4egory = choices[indexPath.row].lowercased()
        self.performSegue(withIdentifier: "search", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search"{
            if let destination = segue.destination as? ViewController2 {
                destination.getSearchTerm(searchString: selectedCategory)
            }
        }
    }
}


