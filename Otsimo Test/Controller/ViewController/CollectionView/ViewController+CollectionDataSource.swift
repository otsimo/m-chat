//
//  ViewController+CollectionDataSource.swift
//  OtsimoTest
//
//  Created by demirci on 31/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation

extension ViewController: UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
     return htmlContents.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "walkThroughCell", for: indexPath) as! WalkThroughCell
        let url = htmlContents[indexPath.row]
        let testHTML = Bundle.main.path(forResource: url, ofType: "html")
        
        do {
            
            if let html = testHTML{
                let contents = try String(contentsOfFile: html, encoding: .utf8)
                let baseUrl = NSURL(fileURLWithPath: testHTML!) //for load css file
                
                cell.webView.loadHTMLString(contents, baseURL: baseUrl as URL)
                return cell
            }
           
        } catch let err {
            Log.error("error \(err)")
        }
        print("*")
        

        return cell
    }
   
    
}
