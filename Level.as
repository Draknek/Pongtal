package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Level extends World
	{
		[Embed(source="images/bg.png")] public static const BgGfx: Class;
		
		public function Level ()
		{
			addGraphic(new Backdrop(BgGfx, true, true));
			add(new Player(-1));
			add(new Player(1));
			add(new Ball());
		}
		
		public override function update (): void
		{
			super.update();
		}
		
		public override function render (): void
		{
			super.render();
		}
	}
}

