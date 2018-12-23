//
//  ViewController.swift
//  adder
//
//  Created by Priyank Varshney on 12/20/18.
//  Copyright © 2018 Priyank Varshney. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        checkPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        imagePicker.delegate = self
        checkPermission()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        imagePicker.delegate = self
        checkPermission()
        
    }
    
    @IBOutlet var ImageView: UIImageView!
    
    @IBOutlet var imageButton: UIButton!
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    @IBAction func imageUpload(){
        ImageView.setNeedsDisplay()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc internal func imagePickerController(_picker: UIImagePickerController, didFinishPickingImageWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("Test")
            ImageView.contentMode = .scaleAspectFit
            ImageView.image = pickedImage
            ImageView.isHidden = false
            print("Getting image")
            guard let image = ImageView.image else { return } // BAIL
            let data = UIImage.jpegData(image)
            
            print(data)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    var buttonState = true
    
    @IBOutlet weak var text1: UITextView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func getInfo(){
        guard let searchContent = searchBar.text else{
            return
        }
        text1.text = "Fetching Data..."
        callApi(search: searchContent)
        buttonState = false;
        sleep(1)
    }
    
    func callApi(search: String){
        let todoEndpoint: String = "http://52.14.26.83/get_nutrition_info/" + search
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /get_nutrition_info")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            let response: String = String(data: responseData, encoding: String.Encoding.utf8) as String!
            
            self.text1.text = response
            print(response)
            
        }
        task.resume()
    }

}

