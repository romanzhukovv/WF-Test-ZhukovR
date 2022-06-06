//
//  ViewController.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("init detail")
        view.backgroundColor = .purple
    }

    deinit {
        print("deinit detail")
    }
}

