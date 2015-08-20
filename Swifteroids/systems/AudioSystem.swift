
import CoreGraphics.CGGeometry
import SpriteKit
import AVFoundation.AVAudioPlayer


class AudioSystem : ListIteratingSystem
{
    var scene : SKScene

    init( scene : SKScene )
    {
        self.scene = scene
        super.init(nodeClass: AudioNode.self, nodeUpdateSelector: "updateNode:time:" )
        warmUp()
    }
    
    private func warmUp()
    {
        do
        {
            let bundle = NSBundle.mainBundle()
            let path = bundle.pathForResource( AudioAsset.ShootGun.rawValue, ofType : nil )
            var player : AVAudioPlayer
            try player = AVAudioPlayer( contentsOfURL: NSURL ( fileURLWithPath : path! ) )
            player.prepareToPlay()
        }
        catch
        {
            print("AVAudioPlayer failure")
        }
    }
    
    func updateNode( node : AudioNode, time : NSNumber )
    {
        for sound in node.audio.toPlay
        {
            scene.runAction( SKAction.playSoundFileNamed( sound, waitForCompletion: false ) )
        }
        
        node.audio.toPlay.removeAll()
    }
}