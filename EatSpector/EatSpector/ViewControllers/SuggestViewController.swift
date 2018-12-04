//
//  SuggestViewController.swift
//  EatSpector
//
//  Created by WaiYanPhyo Hein on 12/1/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import ImageSlideshow
import FirebaseAuth

class SuggestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var recommendations = [String]()
    var newRecommendation: String = ""
    
    var handle: AuthStateDidChangeListenerHandle?

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var ImageView: ImageSlideshow!
    let localSource = [ImageSource(imageString: "hd-201401-r-sausage-and-broccoli-rabe-with-polenta")!, ImageSource(imageString: "beef-noodle-soup-8")!, ImageSource(imageString: "1371606132101")!, ImageSource(imageString: "182_3_9296_jpeg_ad23f8cb-854b-41ea-85b6-e1afd54da69a")!]
 //   let afNetworkingSource = [AFURLSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
//    let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
//    let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
//    let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendations = ["BMW","Audi","Volkswagen"]
        ImageView.slideshowInterval = 5.0
        ImageView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        ImageView.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        ImageView.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        ImageView.activityIndicator = DefaultActivityIndicator()
        ImageView.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        ImageView.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SuggestViewController.didTap))
        ImageView.addGestureRecognizer(recognizer)
        // Do any additional setup after loading the view.
    }

    
    
    //fullscreen images
    @objc func didTap() {
        let fullScreenController = ImageView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    @IBAction func OnLogout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! SignInViewController
        self.present(newViewController, animated: true, completion: nil)

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
