//
//  ViewController.swift
//  iOSTest
//
//  Created by David Rivera on 12/11/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }


}

