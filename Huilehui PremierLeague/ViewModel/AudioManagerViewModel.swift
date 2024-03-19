import Foundation
import AVKit

class AudioManagerViewModel {
    private var chantAudioPlayer: AVAudioPlayer?
    
    func playback(_ team: Team){
        if team.isPlaying { // if play the stop
            chantAudioPlayer?.stop()
        } else { // if not play then play
            guard let path = Bundle.main.path(forResource: "\(team.id.chantFile).mp3", ofType: nil)  else { return } // use guard to be when there is no file will not crash
            let url = URL(fileURLWithPath: path)
            do {
                chantAudioPlayer = try AVAudioPlayer(contentsOf: url)
                chantAudioPlayer?.numberOfLoops = -1 // -1 loop forever
                chantAudioPlayer?.play()
            } catch {
                print(error)
            }
        }
    }
}
