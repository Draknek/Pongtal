package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Level extends World
	{
		[Embed(source="images/bg.png")] public static const BgGfx: Class;
		
		public var ball:Ball;
		public var p1:Player;
		public var p2:Player;
		
		public function Level ()
		{
			addGraphic(new Backdrop(BgGfx, true, true));
			add(ball = new Ball());
			add(p1 = new Player(-1));
			add(p2 = new Player(1));
		}
		
		public override function update (): void
		{
			ball.update();
			p1.update();
			p2.update();
		}
		
		public override function render (): void
		{
			super.render();
		}
	}
}

