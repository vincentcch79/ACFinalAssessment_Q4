//
//  ViewController.swift
//  ACFinalAssessment_Q4
//
//  Created by 張智涵 on 2016/8/4.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import MessageUI

private let reuseIdentifier = "cellIdentifier"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellArr = ["顯示AlertView", "顯示ActionSheet", "撥打117", "開啟設定頁面", "導航到AlphaCamp", "寫信"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView!.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "cellIdentifier")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (UIScreen.mainScreen().bounds.width - 2 * 3) / 2
        let height = (UIScreen.mainScreen().bounds.height / 3 )
        layout.itemSize = CGSize(width: width, height: height)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath) as! CustomCell
        
        cell.customLabel.text = cellArr[indexPath.row]
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: "Suup!!", message: "按錯按鈕臭了嗎？", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "掰掰", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        case 1:
            let alert = UIAlertController(title: "Suup!!", message: "按錯按鈕臭了嗎？", preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "好啦", style: .Default, handler: nil))
            alert.addAction(UIAlertAction(title: "掰掰囉", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        case 2:
            if let url = NSURL(string: "tel://117)") {
                UIApplication.sharedApplication().openURL(url)
            }
        case 3:
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(url)
            }
        case 4:
            let streetName = "104台北市中山區南京東路二段97號".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
            let path = "http://maps.apple.com/?q=" + streetName!
            if let url = NSURL(string: path) {
                UIApplication.sharedApplication().openURL(url)
            }
        case 5:
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["test@test.com"])
                mail.setMessageBody("<p>測試信件!</p>", isHTML: true)
                
                presentViewController(mail, animated: true, completion: nil)
            } else {
                // show failure alert
            }
            
        default:
            break
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

