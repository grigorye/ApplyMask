import ArgumentParser
import CoreGraphics
import Foundation

private struct Arguments: ParsableArguments {
    @Option(help: "Source image")
    var source: String
    
    @Option(help: "Mask image")
    var mask: String
    
    @Option(help: "Output image")
    var output: String
}

struct ApplyMask: ParsableCommand {
    
    public static let configuration = CommandConfiguration(
        abstract: "Apply mask"
    )
    
    func run() {
        let sourceImage = cgImageFromPng(at: arguments.source)
        let mask = cgImageFromPng(at: arguments.mask).mask()!
        let outputImage = sourceImage.masking(mask, backgroundColor: .black)
        savePng(outputImage, at: arguments.output)
    }

    @OptionGroup private var arguments: Arguments
}

private func cgImageFromPng(at path: String) -> CGImage {
    let pngDataProvider = CGDataProvider(url: URL(fileURLWithPath: path) as CFURL)!
    let image = CGImage(pngDataProviderSource: pngDataProvider, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)!
    return image
}

private func savePng(_ image: CGImage, at path: String) {
    let url = URL(fileURLWithPath: path) as CFURL
    
    let destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, nil)!
    
    CGImageDestinationAddImage(destination, image, nil)
    
    guard CGImageDestinationFinalize(destination) else { fatalError() }
}
