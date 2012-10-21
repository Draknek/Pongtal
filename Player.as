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
			
			x -= width*0.5;
			y -= height*0.5;
		}
		
		public override function update (): void
		{
			
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
			
			g.drawEllipse(x, y, width, height);
			
			FP.buffer.draw(FP.sprite);
		}
	}
}

