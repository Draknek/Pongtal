package
{
	import net.flashpunk.*;
	
	public class Audio
	{
		[Embed(source="audio/bounce.mp3")] public static const Sfx_bounce:Class;
		[Embed(source="audio/portal.mp3")] public static const Sfx_portal:Class;
		[Embed(source="audio/start.mp3")] public static const Sfx_start:Class;
		[Embed(source="audio/audio.swf#ball_loop")] public static const Sfx_ball_loop:Class;
		
		[Embed(source="audio/point1_blue.mp3")]   public static const Sfx_point1_blue:Class;
		[Embed(source="audio/point1_orange.mp3")] public static const Sfx_point1_orange:Class;
		[Embed(source="audio/point2_blue.mp3")]   public static const Sfx_point2_blue:Class;
		[Embed(source="audio/point2_orange.mp3")] public static const Sfx_point2_orange:Class;
		[Embed(source="audio/point3_blue.mp3")]   public static const Sfx_point3_blue:Class;
		[Embed(source="audio/point3_orange.mp3")] public static const Sfx_point3_orange:Class;
		[Embed(source="audio/point4_blue.mp3")]   public static const Sfx_point4_blue:Class;
		[Embed(source="audio/point4_orange.mp3")] public static const Sfx_point4_orange:Class;
		[Embed(source="audio/point5_blue.mp3")]   public static const Sfx_point5_blue:Class;
		[Embed(source="audio/point5_orange.mp3")] public static const Sfx_point5_orange:Class;
		
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
		
		public static function play (sound:String, color:String = ""):void
		{
			if (sound == "point") {
				sound = sound + int(FP.rand(5) + 1);
			}
			
			if (color) {
				sound = sound + "_" + color;
			}
			
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
