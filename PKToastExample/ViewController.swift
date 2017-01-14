//
//  ViewController.swift
//  PKToastExample
//
//  Created by Pramod Kumar on 15/01/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//

import UIKit

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
        PKToast.shared.show(message: "you've clicked!  hf k fkfk fhjk jkjhjfj jkjk hchcghk ckhg ckgc fghk fhkf hkf kff kyfu ", animated: true)
    }
}

