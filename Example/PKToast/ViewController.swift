//
//  ViewController.swift
//  PKToast
//
//  Created by Pramod Kumar on 01/15/2017.
//  Copyright (c) 2017 Pramod Kumar. All rights reserved.
//

import UIKit
import PKToast

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    //MARK:-
    @IBOutlet weak var showToastButton: UIButton!
    
    
    //MARK:- View Life Cycle
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- IBActions Methos
    //MARK:-
    @IBAction func showToastButtonTapped(_ sender: UIButton) {
        PKToast.shared.show(message: "Button Tapped", animated: true)
    }
}
