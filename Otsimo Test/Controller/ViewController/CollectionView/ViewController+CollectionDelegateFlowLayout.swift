//
//  ViewController+CollectionDelegate.swift
//  OtsimoTest
//
//  Created by demirci on 31/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation


extension ViewController : UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var newSize: CGSize?
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        newSize = CGSize(width: width, height: height)
        
        return newSize!
    }
    
}
