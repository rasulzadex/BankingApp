import UIKit

class StickyCollectionViewFlowLayout2: UICollectionViewFlowLayout {
    var firstItemTransform: CGFloat?
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let items = NSArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        
        var headerAttributes: UICollectionViewLayoutAttributes?
        self.firstItemTransform = nil
        
        items.enumerateObjects(using: { (object, _, _) -> Void in
            let attributes = object as! UICollectionViewLayoutAttributes
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                headerAttributes = attributes
            } else {
                self.atributeLayout(attributes, headerAttributes: headerAttributes)
            }
        })
        
        return items as? [UICollectionViewLayoutAttributes]
    }
    
    func atributeLayout(_ attributes: UICollectionViewLayoutAttributes, headerAttributes: UICollectionViewLayoutAttributes?) {
        let minY = self.collectionView!.bounds.minY + self.collectionView!.contentInset.top
        let maxY = attributes.frame.origin.y + attributes.frame.height / 2 + 80
        let finalY = max(minY, maxY)
        var origin = attributes.frame.origin
        let deltaY = (finalY - origin.y) / attributes.frame.height + 100
        
        if let itemTransform = self.firstItemTransform {
            let scale = 1 - deltaY * itemTransform
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        origin.y = finalY
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
        attributes.zIndex = attributes.indexPath.row
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
