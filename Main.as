package
{
	import net.flashpunk.*;
	import net.flashpunk.debug.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class Main extends Engine
	{
		public static var singlePlayer:Boolean = true;
		
		[Embed(source="/usr/share/fonts/truetype/freefont/FreeSansBold.ttf", embedAsCFF="false", fontFamily = "sansfont", fontWeight= "bold")]
		public static const Font: Class;
		
		public function Main () 
		{
			super(630, 420, 60, true);
			Audio.init();
			Text.font = "sansfont";
			FP.world = new Menu();
		}
		
		public override function init (): void
		{
			sitelock("draknek.org");
			
			super.init();
		}
		
		public override function update (): void
		{
			if (Input.pressed(FP.console.toggleKey)) {
				// Doesn't matter if it's called when already enabled
				FP.console.enable();
			}
			
			super.update();
		}
		
		public function sitelock (allowed:*):Boolean
		{
			var url:String = FP.stage.loaderInfo.url;
			var startCheck:int = url.indexOf('://' ) + 3;
			
			if (url.substr(0, startCheck) == 'file://') return true;
			
			var domainLen:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLen);
			
			if (allowed is String) allowed = [allowed];
			for each (var d:String in allowed)
			{
				if (host.substr(-d.length, d.length) == d) return true;
			}
			
			parent.removeChild(this);
			throw new Error("Error: this game is sitelocked");
			
			return false;
		}
	}
}

