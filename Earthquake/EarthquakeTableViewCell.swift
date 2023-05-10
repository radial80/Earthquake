//
//  EarthquakeTableViewCell.swift
//  Earthquake
//
//  Created by Recep Uyduran on 7.03.2023.
//

import UIKit
protocol EarthquakeTableViewCellDelegate: AnyObject {
}
class EarthquakeTableViewCell: UITableViewCell {

    @IBOutlet weak var yerLabel: UILabel!
    @IBOutlet weak var tarihLabel: UILabel!
    @IBOutlet weak var saatLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!

    weak var delegate : EarthquakeTableViewCellDelegate?
    var cellIndex: Int = 0

    func setCell(data: EarthquakeManagerData, delegate: EarthquakeTableViewCellDelegate, index: Int) {
        yerLabel.text = data.yer
        tarihLabel.text = data.tarih
        saatLabel.text = data.saat
        magnitudeLabel.text = data.mlString
        self.delegate = delegate
        cellIndex = index
    }
}
