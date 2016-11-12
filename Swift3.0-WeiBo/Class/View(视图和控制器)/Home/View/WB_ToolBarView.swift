//
//  WB_ToolBarView.swift
//  Swift3.0-WeiBo
//
//  Created by X-Liang on 2016/11/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

import UIKit

class WB_ToolBarView: UIView {
    @IBOutlet weak var retweetedButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    weak var viewModel: WB_StatusViewModel? {
        didSet {
            self.retweetedButton.setTitle(viewModel?.retweetedStr, for: .normal)
            self.commentButton.setTitle(viewModel?.commentStr, for: .normal)
            self.likeButton.setTitle(viewModel?.likeStr, for: .normal)
        }
    }
}
