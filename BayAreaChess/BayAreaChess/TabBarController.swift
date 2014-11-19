//
//  TabBarController.swift
//  FrostedSidebar
//
//  Created by Evan Dekhayser on 8/28/14.
//  Copyright (c) 2014 Evan Dekhayser. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var sidebar: FrostedSidebar!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        delegate = self;
        tabBar.hidden = true;
        
        sidebar = FrostedSidebar(itemImages: [
            UIImage(named: "home.png")!,
            UIImage(named: "tournaments.png")!,
            UIImage(named: "about.png")!,
            UIImage(named: "settings.png")!],
            colors: [
                UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 1),
                UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 1),
                UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 1),
                UIColor(red: 119/255, green: 152/255, blue: 255/255, alpha: 1)],
            selectedItemIndices: NSIndexSet(index: 0));
        
        sidebar.isSingleSelect = true;
        sidebar.actionForIndex = [
            0: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 0}) },
            1: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 1}) },
            2: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 2}) },
            3: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 3}) }];
        
    }
    
}