//
//  SegueStyle3.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 17/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class SegueStyle3: UIStoryboardSegue {
    override func perform() {
        transition3()
    }
    
    func transition3() {
        let destination = self.destination
        let source = self.source
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            destination.view.transform = CGAffineTransform.identity
        }, completion: {finished in
            source.present(destination, animated: false, completion: nil)
        })    }}
