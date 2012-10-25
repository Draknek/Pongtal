package
{
	import net.flashpunk.*;
	
	public class Audio
	{
		[Embed(source="audio/bounce.mp3")] public static const Sfx_bounce:Class;
		[Embed(source="audio/portal.mp3")] public static const Sfx_portal:Class;
		[Embed(source="audio/start.mp3")] public static const Sfx_start:Class;
		[Embed(source="audio/audio.swf#ball_loop")] public static const Sfx_ball_loop:Class;
		
		public static var loop:Sfx;
		
		public static function init ():void
		{
			loop = new Sfx(Sfx_ball_loop);
			
			loop.loop(0.0, 0.0);
		}
		
		private static var sounds:Object = {};
		
		public static const VOLUMES:Object = {
			"bounce": 0.3
		}
		
		public static function play (sound:String):void
		{
			if (! sounds[sound]) {
				var embed:Class = Audio["Sfx_" + sound];
				
				if (embed) {
					sounds[sound] = new Sfx(embed);
				}
			}
			
			if (sounds[sound]) {
				var volume:Number = 1.0;
				
				if (VOLUMES[sound]) volume = VOLUMES[sound];
				
				sounds[sound].play(volume);
			}
		}
	}
}
