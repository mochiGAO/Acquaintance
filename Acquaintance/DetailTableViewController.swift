//
//  DetailTableViewController.swift
//  Acquaintance
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 GAOOcean. All rights reserved.
//

import UIKit



class DetailTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var person: Person?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var notesTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        nameTextField.text = person?.name
        if let photo = person?.photo {
            photoImageView.image = photo
        }
        notesTextView.text = person?.notes
        navigationItem.title = "Details"
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or pushpresentation), this view controller needs to be dismissed in two different ways.
        if presentingViewController is UINavigationController {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if nameTextField.text == nil || nameTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Invalid Data",message: "The name cannot be empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK",style:.cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: "SaveToList", sender: self)
        }
    }


    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveToList" {
            if person == nil {
                person = Person(nameTextField.text!)
            }
            else {
                person!.name = nameTextField.text!
            }
            person!.photo = photoImageView.image
            person!.notes = notesTextView.text
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "",message: "Choose your photo source", preferredStyle: .actionSheet)
            if let popoverController =
                photoSourceRequestController.popoverPresentationController, let cell =
                tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
            let photoLibraryAction = UIAlertAction(title: "Photo library",style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()

                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            let cameraAction = UIAlertAction(title: "Camera",style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated:true, completion: nil)
                    
                }
            }
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cameraAction)
            present(photoSourceRequestController, animated: true,
                    completion: nil)
        }
    }
    func imagePickerController
        (_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage]as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }

    

}
