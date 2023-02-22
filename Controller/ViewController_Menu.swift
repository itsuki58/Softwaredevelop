//
//  ViewController_Menu.swift
//  GroupF
//
//  Created by 小川　花凜 on 2019/12/12.
//  Copyright © 2019 津覇　翔也. All rights reserved.
//

import UIKit
import FLAnimatedImage

class ViewController_Menu: UIViewController {

    @IBOutlet weak var menulabel: UILabel!
    @IBOutlet weak var image1: FLAnimatedImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var introduce_label: UILabel!
    @IBOutlet weak var back_game: UIButton!
    @IBOutlet weak var back_title: UIButton!

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Set_View()
        Gif_road()

    }
    
    func Gif_road(){
        //gif表示のための文
        let path1 : String = Bundle.main.path(forResource: "main_cha", ofType: "gif")!
        let url = URL(fileURLWithPath: path1)
        let gifData = try? Data(contentsOf: url)
        let imageData1 = try? FLAnimatedImage(animatedGIFData: gifData)
        image1.animatedImage = imageData1
    }
    
    func Set_View(){
        let backgroundImage = UIImage(named: "haikei")!
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
            
        self.namelabel.layer.cornerRadius = 10
        self.namelabel.layer.masksToBounds = true
        self.namelabel.layer.borderWidth = 3
            
        self.introduce_label.layer.cornerRadius = 20
        self.introduce_label.layer.masksToBounds = true
        self.introduce_label.layer.borderColor = UIColor.blue.cgColor
        self.introduce_label.layer.borderWidth = 3
        introduce_label.numberOfLines = 0;
        
        self.back_game.layer.cornerRadius = 10
        self.back_game.layer.masksToBounds = true
        self.back_game.layer.borderColor = UIColor.white.cgColor
        self.back_game.layer.borderWidth = 3
            
        self.back_title.layer.cornerRadius = 10
        self.back_title.layer.masksToBounds = true
        self.back_title.layer.borderColor = UIColor.white.cgColor
        self.back_title.layer.borderWidth = 3
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
