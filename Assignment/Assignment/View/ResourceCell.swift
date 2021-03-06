//
//  ResourceCell.swift
//  Assignment
//
//  Created by Sai Pasumarthy on 23/11/17.
//  Copyright © 2017 SparklerTechies. All rights reserved.
//

import UIKit

protocol ResourceCellDelegate {
    func downloadTapped(_ cell: ResourceCell)
}

class ResourceCell: UITableViewCell {
    // Delegate identifies download action,
    // then passes this to a download service method.
    var delegate: ResourceCellDelegate?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var resourceTitleLabel: UILabel!
    @IBOutlet weak var resourceDownloadButton: UIButton!
    
    //MARK:- IBActions
    @IBAction func downloadResource(_ sender: Any) {
        delegate?.downloadTapped(self)
    }
    
    func configure(resource: Resource, downloaded: Bool, download: Download?) {
        switch resource.resourceType {
        case .image:
            resourceTitleLabel.text = "Image"
        case .pdf:
            resourceTitleLabel.text = "PDF"
        case .video:
            resourceTitleLabel.text = "Video"
        }
        var showDownloadControls = false
        // Non-nil Download object means a download is in progress
        var title = "Download"
        if downloaded {
            title = resource.resourceType == .video ? "Play" : "View"
        } else {
            if let download = download {
                showDownloadControls = true
                title = download.isDownloading ? "Downloading..." : "Download"
            }
        }
        resourceDownloadButton.setTitle(title, for: .normal)
        progressBar.isHidden = !showDownloadControls
        progressLabel.isHidden = !showDownloadControls
        // If the resource is already downloaded, enable cell selection and hide the Download button
        selectionStyle = downloaded ? UITableViewCellSelectionStyle.gray : UITableViewCellSelectionStyle.none
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
        progressBar.progress = progress
        let textStr = String(format: "%.1f%% of %@", progress * 100, totalSize)
        progressLabel.text = textStr
    }
}
