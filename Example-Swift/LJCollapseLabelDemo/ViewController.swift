//
//  ViewController.swift
//  LJCollapseLabelDemo
//
//  Created by Liguo Jiao on 7/12/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

import UIKit
import LJCollapseLabel


class ViewController: UIViewController {
    @IBOutlet weak var collapseLabel: LJCollapseLabel!
    override func loadView() {
        super.loadView()
        collapseLabel.isCollapsed = true
        collapseLabel.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        collapseLabel.minimumHeight = 50
        #if DEBUG
        collapseLabel.layer.borderColor = UIColor.blue.cgColor
        collapseLabel.layer.borderWidth = 1
        #endif
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        analytics()
    }
}

extension ViewController {
    fileprivate func analytics() {
        collapseLabel.textHeightChangedCallback = {
            //You can do your stuff here, i.e. event tracking, data collection
        }
    }
}

