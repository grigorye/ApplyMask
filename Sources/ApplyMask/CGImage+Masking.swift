import CoreGraphics
import CoreImage

extension CGImage {
    
    func masking(_ mask: CGImage, backgroundColor: CGColor) -> CGImage {
        masking(mask)!.renderedWithBackground(backgroundColor)
    }
    
    func mask() -> CGImage {
        CGImage(
            maskWidth: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: bytesPerRow,
            provider: dataProvider!,
            decode: nil,
            shouldInterpolate: false
        )!
    }
    
    func colorInverted() -> CGImage {
        let ciImage = CIImage(cgImage: self)
        let filter = CIFilter(name: "CIColorInvert")!
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let context = CIContext(options: nil)
        let outputImage = filter.outputImage!
        return context.createCGImage(outputImage, from: outputImage.extent)!
    }
    
    func renderedWithBackground(_ color: CGColor) -> CGImage {
        let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
        )!
        let frame = CGRect(origin: .zero, size: .init(width: width, height: height))
        context.setFillColor(color)
        context.fill(frame)
        context.draw(self, in: frame)
        
        return context.makeImage()!
    }
}
