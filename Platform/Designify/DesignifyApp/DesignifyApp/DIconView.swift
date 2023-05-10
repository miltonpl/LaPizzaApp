//
//  DIconView.swift
//  DesignifyApp
//
//  Created by Milton Palaguachi on 5/10/23.
//

import SwiftUI
import Designify

struct GridCell: View {
    var image: UIImage
    var title: String

    var body: some View {
        VStack{
            Image(uiImage: image)
            Text(title)
        }
        
    }
}
struct DIconView: View {
    static let columns = 4
    let cellSize = CGFloat(UIScreen.main.bounds.width / CGFloat(columns))
    let icons = DIcon.allCases
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ForEach(icons.chunks(DIconView.columns), id: \.self) { iconChunk in
                    HStack(spacing: 0) {
                        ForEach(iconChunk, id: \.self) { icon in
                            GridCell(image: icon.uiImage, title: icon.iconAccessibilityLabel)
                                .frame(width: self.cellSize)
                        }
                    }
                }
            }
        }
    }
}

struct DIconView_Previews: PreviewProvider {
    static var previews: some View {
        DIconView()
    }
}
extension Array {
    func chunks(_ checkSize: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: checkSize).map {
            Array(self[$0..<Swift.min($0 + checkSize, self.count)])
        }
    }
}
