//
//  ViewController.swift
//  savePhoto
//
//  Created by sky on 2016/12/7.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    var newphotoArray:[String] = []

    @IBOutlet weak var showPhoto: UIImageView!
    
    @IBAction func takephotoButton(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadfile()
        let path = NSHomeDirectory()//為了印出路徑
        print(path)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //print("info \(info)")
        let image = info[UIImagePickerControllerOriginalImage]
        self.showPhoto.image = image as? UIImage
        //取得路徑
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        //檔名
        let interval = Date.timeIntervalSinceReferenceDate
        let name = "\(interval).jpg"
        let url = docUrl?.appendingPathComponent(name)
        print(url!)
        //把圖片存在App裡
        let data = UIImageJPEGRepresentation(self.showPhoto.image!, 0.9)
        try! data?.write(to: url!)
        self.dismiss(animated: true, completion: nil)
        newphotoArray.append(name)
        savefile()
        
        
    }
    
    //儲存紀錄位址的photoArray
    func savefile(){
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("newphotoArray.txt")
        let arrary = newphotoArray
        (arrary as NSArray).write(to: url!, atomically: true)
        
    }
    //讀取記錄位址的photoArray
    func loadfile(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("newphotoArray.txt")
        
        if let array = NSArray(contentsOf: url!){
            newphotoArray = array as! [String]
        }// if array
        //print(newphotoArray)
    }//loadfile


}

