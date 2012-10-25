package
{
	import net.flashpunk.*;
	
	public class Audio
	{
		[Embed(source="audio/bounce.mp3")] public static const Sfx_bounce:Class;
		[Embed(source="audio/portal.mp3")] public static const Sfx_portal:Class;
		[Embed(source="audio/start.mp3")] public static const Sfx_start:Class;
		
		private static var sounds:Object = {};
		
		public static function play (sound:String):void
		{
			if (! sounds[sound]) {
				var embed:Class = Audio["Sfx_" + sound];
				
				if (embed) {
					sounds[sound] = new Sfx(embed);
				}
			}
			
			if (sounds[sound]) {
				sounds[sound].play();
			}
		}
	}
}
