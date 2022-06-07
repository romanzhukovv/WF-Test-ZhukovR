//
//  ViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init detail")
//        print(photo?.urls.full)
    }

    deinit {
        print("deinit detail")
    }
}

