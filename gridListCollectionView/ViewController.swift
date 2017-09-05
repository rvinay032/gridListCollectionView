//
//  ViewController.swift
//  gridListCollectionView
//
//  Created by appinventiv on 05/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var clickOnButton = false
    var expandedSections : NSMutableSet = []
    var isClicked = true
    
    

    
    @IBAction func gridBtnTap(_ sender: UIButton) {
        if clickOnButton == false{
            clickOnButton = true
        }else{
            clickOnButton = false
        }
        collectionViewOutlet.reloadData()
    
    }
    
    
    @IBAction func goBtnTap(_ sender: UIButton) {
    
        print("Section tapped")
        
        let sec = sender.tag
        print(sec)
        let shouldExpand = !expandedSections.contains(sec)
        print(shouldExpand)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(sec)
   
            }
        else
        
        {
         expandedSections.removeAllObjects()
          }
        collectionViewOutlet.reloadData()
    }
    
    
    
@IBOutlet weak var collectionViewOutlet: UICollectionView!
    

    struct Objects {
        var sectionname: String
        var name:[String]
        init(sectionname: String, name: [String]) {
            self.sectionname = sectionname
            self.name = name
        }
    }
    
  var objArr = [Objects]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        
        objArr = [Objects(sectionname: "Dogs", name: ["rottwiler", "pug", "bulldog", "boxer", "german", "golden"]), Objects(sectionname: "Laptops", name: ["lappy1", "lappy2","lappy3","lappy4","lappy5","lappy6","lappy7","lappy8","lappy9","lappy10","lappy11", "lappy12", "lappy13"]), Objects(sectionname: "Mobiles", name: ["samsung", "sony", "lumia", "vivo", "mi"])]
        
    }

    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
        return objArr[section].name.count
        }
        else {
        return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell else { fatalError() }
        cell.imageLabel.text = self.objArr[indexPath.section].name[indexPath.row]
        cell.imageOutlet.image = UIImage(named: objArr[indexPath.section].name[indexPath.row])
        return cell
    }
    // height width of header////
    
  //  ---------------- Set height and width while clicking on grid button -------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        guard  let obOfHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderClass", for: indexPath) as? HeaderClass else{fatalError()}
        if self.clickOnButton == false{
            //            obOfHeader.girdButton.setTitle("Table", for: .normal)
            return CGSize(width: 100, height: 170)
        }else{
            let cellWidth = UIScreen.main.bounds.size.width
            return CGSize(width: cellWidth, height: 100)
            //            obOfHeader.girdButton.setTitle("Grid", for: .normal)
            
        }
        
    }
    
    //------------------ Section Header---------------------
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "section", for: indexPath) as! SectionClass
        headerView.headerlabelOutlet.text = objArr[indexPath.section].sectionname
        headerView.goBtnoutlet.tag = indexPath.section
        return headerView
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return objArr.count
    }
}


class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
    
}

class SectionClass: UICollectionReusableView {
    
    @IBOutlet weak var goBtnoutlet: UIButton!
    
    @IBOutlet weak var gridBtnOut: UIButton!
    
    @IBOutlet weak var headerlabelOutlet: UILabel!
    
}
