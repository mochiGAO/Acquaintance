//
//  ListTableViewController.swift
//  Acquaintance
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 GAOOcean. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController,UISearchResultsUpdating {
    var acqList = [Person]()
    var sampleList = [Person("Ameir Al-Zoubi"),  Person("Bill Dudney"),Person("Bob McCune"), Person("Brent Simmons"), Person("Cesare Rocchi"), Person("Chad Sellers"), Person("Conrad Stoll"), Person("Daniel Pasco"), Person("Jaime Newberry"), Person("James Dempsey"), Person("JoshA bernathy"), Person("Justin Miller"), Person("KenAuer"), Person("Kevin Harwood"), Person("KyleRichter"), Person("Manton Reece"), Person("Marcus Zarra"), Person("Mark Pospesel"), Person("Matt Drance"), Person("Michael Simmons"),Person("Michele Titolo"), Person("Michael Simmons"), Person("Rene Cacheaux"), Person("Rob Napier"), Person("Scott McAlister"), Person("SeanMcMains")]
    
    var searchController: UISearchController!
    var searchResults = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for person in acqList {
        //    person.photo = UIImage(named: person.name)
        //    person.notes = "This is the memo for " + person.name
            //navigationController?.navigationBar.prefersLargeTitles = true
        //}
        //pad
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search acquaitance..."
        searchController.searchBar.tintColor = UIColor(red: 218.0/255.0, green: 37.0/255.0, blue: 54.0/255.0, alpha: 1.0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            searchResults = acqList.filter() { (person) -> Bool in
                return person.name.localizedCaseInsensitiveContains(searchText)
            }
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        }
        else {
        return acqList.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let person = acqList[indexPath.row]
        // Configure the cell...

        if let photo = person.photo {
            cell.imageView?.image = photo
            //cell.imageView?.contentMode = .scaleAspectFill
            //cell.imageView?.clipsToBounds = true
        }
        else {
            cell.imageView?.image = UIImage(named:"photoalbum")
        }
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.notes
        return cell*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ListCell", for: indexPath) as! ListTableViewCell
        //let person = acqList[indexPath.row]
        let person = (searchController.isActive) ?
            searchResults[indexPath.row] : acqList[indexPath.row]
        // Configure the cell...
        if let photo = person.photo {
            cell.photoImageView.image = photo
        }
        else {
            cell.photoImageView.image = UIImage(named:"photoalbum")
        }
        cell.nameLabel.text = person.name
        cell.notesLabel.text = person.notes
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            acqList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insertit into the array, and add a new row to the table view
        }
    }*/
    
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        if segue.identifier == "SaveToList",
            let detailViewController = segue.source as?
            DetailTableViewController,
        let person = detailViewController.person {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                 // Update an existing person.
                acqList[(selectedIndexPath as NSIndexPath).row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new person.
                let newIndexPath = IndexPath(row: acqList.count, section: 0)
                acqList.append(person)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
        saveList()
    }
    
    
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail",
            let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as?
        DetailTableViewController {
            //detailViewController.person = acqList[indexPath.row]
            
            detailViewController.person = (searchController.isActive) ?
                searchResults[indexPath.row] : acqList[indexPath.row]
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    override func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath) ->
        UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title:"Delete") { (action, sourceView, completionHandler) in self.acqList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }
            let shareAction = UIContextualAction(style: .normal, title:"Share") { (action, sourceView, completionHandler) in let defaultText = "Meet " + (self.acqList[indexPath.row].name)
                var activityController: UIActivityViewController
                if let imageToShare = self.acqList[indexPath.row].photo {
                    activityController = UIActivityViewController(activityItems:[defaultText,imageToShare], applicationActivities: nil)
                }
                else {
                    activityController = UIActivityViewController(activityItems:[defaultText], applicationActivities: nil)
                }
                self.present(activityController, animated: true, completion:nil)
                completionHandler(true)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
    }
    func saveList() {
        let isSuccessfulSave =
            NSKeyedArchiver.archiveRootObject(acqList, toFile:
                Person.ArchiveURL.path)
        if !isSuccessfulSave {
            logDebug("Failed to save the acquaintance list ...")
        } }
    func loadList() -> [Person]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile:
            Person.ArchiveURL.path) as? [Person]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Load any saved acquaitance, otherwise load sample data.
        if let savedList = loadList() {
            acqList += savedList
        } else {
            // Load the sample data.
            for person in sampleList {
                person.photo = UIImage(named: person.name)
                acqList.append(person)
            }
        }
    }

}
