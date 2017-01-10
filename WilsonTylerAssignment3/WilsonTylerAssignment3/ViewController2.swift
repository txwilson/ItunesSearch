//
//  ViewController2.swift
//  WilsonTylerAssignment3
//
//  Created by Tyler Wilson on 10/18/16.
//  Copyright © 2016 Tyler Wilson. All rights reserved.
//

import UIKit

class ViewController2:  UIViewController{

    
    override func viewDidLoad() {
        
    }
    
    var searchTerm:String = ""
    var searchEntity:String = ""
    
    func getSearchTerm(searchString: String){
        searchEntity = searchString.lowercased()
    }
    
    
    func parse(){
        var urlString = ""
        if(searchEntity == "audio and video"){
            urlString = "https://itunes.apple.com/search?entity=musicArtist&entity=album&entity=podcast&entity=musicVideo&entity=audiobook&entity=tvSeason&term=\(searchTerm)"

        }else{
            urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=\(searchEntity)"

        }
        let convUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)
        let url = NSURL(string: convUrl! as String)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: url! as URL, completionHandler: {data, response, error -> Void in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    self.list = (jsonResult["results"] as! NSArray)
                    self.displayInfo()
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                }
                
            }catch{}
        })
        task.resume()
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int)-> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!)-> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: "cell")
        let imgURL = NSURL(string: getInfo.artwork)
        let imgData = NSData(contentsOf: imgURL as! URL)
        switch searchEntity {
        case "software":
            cell.textLabel?.text = getInfo.artist
            cell.detailTextLabel?.text = getInfo.price
        case "movie":
            cell.textLabel?.text = getInfo.trackName
            cell.detailTextLabel?.text = getInfo.contentAdvisoryRating
            //cell.imageView?.image = UIImage(data: imgData as! Data)
        case "audio and video":
            cell.textLabel?.text = getInfo.trackName
            cell.detailTextLabel?.text = getInfo.collectionName
        default:
            cell.textLabel?.text = getInfo.trackName
            cell.detailTextLabel?.text = getInfo.collectionName

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        self.performSegue(withIdentifier: "moreInfo", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo"{
            if let destination = segue.destination as? ViewController3 {
                infoArray()
                destination.getJsonInfo(array: arrayOfInfo)
            }
        }
    }


    
    @IBOutlet weak var search: UITextField!
    @IBAction func searchButton(_ sender: AnyObject) {
        searchTerm = search.text!
        parse()
    }

    
    var list: NSArray = []
    var info: [jsonInfo] = []
    var getInfo = jsonInfo()
    var name: String = ""
    var arrayOfInfo: [String] = []
    
    func infoArray(){
        arrayOfInfo.append(getInfo.artist)
        arrayOfInfo.append(getInfo.price)
        arrayOfInfo.append(getInfo.supportedDevices)
        arrayOfInfo.append(getInfo.description)
        arrayOfInfo.append(getInfo.genres)
        arrayOfInfo.append(getInfo.primaryGenre)
        arrayOfInfo.append(getInfo.trackHdPrice)
        arrayOfInfo.append(getInfo.longDescription)
        arrayOfInfo.append(getInfo.artwork)
        
    }
    
    struct jsonInfo{
        var price: String = String()
        var artist: String = String()
        var trackName: String = String()
        var collectionName: String = String()
        var contentAdvisoryRating: String = String()
        var supportedDevices: String = String()
        var description: String = String()
        var genres: String = String()
        var primaryGenre: String = String()
        var trackHdPrice: String = String()
        var longDescription: String = String()
        var artwork: String = String()

    }
    
    
    func displayInfo(){
        if let results = list[0] as? NSDictionary{
            if let price = results["formattedPrice"] as? String{
                getInfo.price = price
                info.append(getInfo)
            }
            if let artist = results["artistName"]as? String{
                getInfo.artist = artist
                info.append(getInfo)
            }
            if let track = results["trackName"]as? String{
                getInfo.trackName = track
                info.append(getInfo)
            }
            if let collection = results["collectionName"]as? String{
                getInfo.collectionName = collection
                info.append(getInfo)
            }
            if let contentRating = results["contentAdvisoryRating"]as? String{
                getInfo.contentAdvisoryRating = contentRating
                info.append(getInfo)
            }
            if let devices = results["supportedDevices"]as? String{
                getInfo.supportedDevices = devices
                info.append(getInfo)
            }
            if let description = results["description"]as? String{
                getInfo.description = description
                info.append(getInfo)
            }
            if let genre = results["genres"]as? String{
                getInfo.genres = genre
                info.append(getInfo)
            }
            if let primaryGenre = results["primaryGenreName"]as? String{
                getInfo.primaryGenre = primaryGenre
                info.append(getInfo)
            }
            if let trackHdPrice = results["trackHdPrice"]as? String{
                getInfo.trackHdPrice = trackHdPrice
                info.append(getInfo)
            }
            if let longDescription = results["longDescription"]as? String{
                getInfo.longDescription = longDescription
                info.append(getInfo)
            }
            if let artwork = results["artworkUrl60"]as? String{
                getInfo.artwork = artwork
                info.append(getInfo)
            }
        }

    }
    
}
