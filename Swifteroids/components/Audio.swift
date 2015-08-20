
enum AudioAsset : String
{
    case ExplodeAsteroid = "asteroid.wav"
    case ExplodeShip = "ship.wav"
    case ShootGun = "shoot.wav"
}

class Audio : NSObject
{
    var toPlay : [ String ] = []
    
    func play ( sound : String )
    {
        toPlay.append(sound)
    }
}
