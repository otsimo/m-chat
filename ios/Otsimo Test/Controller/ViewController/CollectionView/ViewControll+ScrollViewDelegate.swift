//
//  ViewControll+ScrollViewDelegate.swift
//  OtsimoTest
//
//  Created by demirci on 02/02/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


extension ViewController : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let currentPage = collectionView.contentOffset.x / pageWidth
        
        if (0.0 != fmodf(Float(currentPage), 1.0))
        {
            pageControl.currentPage = Int(currentPage) + 1;
        }
        else
        {
            pageControl.currentPage = Int(currentPage);
        }
    }
}
