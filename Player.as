package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import flash.display.*;
	
	public class Player extends Entity
	{
		[Embed(source="images/portal.png")] public static const Gfx: Class;
		
		public var vy: Number = 0;
		
		public var color:uint;
		
		public function Player (side:int)
		{
			x = FP.width*0.5 + side*(FP.width*0.5 - 40);
			y = FP.height*0.5;
			
			color = (side < 0) ? 0xf17d00 : 0x0270cf;
			
			width = 40;
			height = 100;
			
			y -= height*0.5;
		}
		
		public override function update (): void
		{
			var level:Level = world as Level;
			var ball:Ball = level.ball;
			
			var y1:Number = y;
			var y2:Number = y + height;
			
			if (ball.y >= y1 && ball.y <= y2) {
				if ((ball.x < x) != (ball.oldX < x)) {
					var other:Player = (level.p1 == this) ? level.p2 : level.p1;
					
					ball.x += other.x - x;
					ball.oldX = ball.x;
				}
			}
		}
		
		public override function render (): void
		{
			renderPortal();
		}
		
		public function renderPortal (): void
		{
			var g:Graphics = FP.sprite.graphics;
			
			g.clear();
			
			g.lineStyle(3, color);
			
			g.drawEllipse(x - width*0.5, y, width, height);
			
			FP.buffer.draw(FP.sprite);
		}
	}
}

