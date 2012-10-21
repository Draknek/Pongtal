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
			
			y += side*20;
			
			initPortal();
		}
		
		public function get other ():Player {
			var level:Level = world as Level;
			return (level.p1 == this) ? level.p2 : level.p1;
		}
		
		public override function update (): void
		{
			var level:Level = world as Level;
			var ball:Ball = level.ball;
			
			var y1:Number = y;
			var y2:Number = y + height;
			
			if (ball.y >= y1 && ball.y <= y2) {
				if ((ball.x < x) != (ball.oldX < x)) {
					ball.x += other.x - x;
					ball.y += other.y - y;
					ball.oldX = ball.x;
					ball.oldY = ball.y;
				}
			}
		}
		
		public override function render (): void
		{
			renderPortal();
		}
		
		public var image:Image;
		public var buffer:BitmapData;
		public var drawMask:BitmapData;
		
		public function initPortal (): void
		{
			buffer = new BitmapData(width, height, false, 0x0);
			
			image = new Image(buffer);
			
			image.originX = width*0.5;
			
			graphic = image;
			
			drawMask = new BitmapData(width, height, true, 0x0);
			
			var g:Graphics = FP.sprite.graphics;
			
			g.clear();
			
			g.beginFill(0xFFFFFF);
			
			g.drawEllipse(0, 0, width, height);
			
			drawMask.draw(FP.sprite);
		}
		
		public function renderPortal (): void
		{
			var other:Player = this.other;
			
			world.camera.x = other.x - width*0.5;
			world.camera.y = other.y;
			
			var level:Level = world as Level;
			
			level.bg.renderTarget = buffer;
			level.bg.render();
			level.bg.renderTarget = null;
			
			level.ball.renderTarget = buffer;
			level.ball.render();
			level.ball.renderTarget = null;
			
			world.camera.x = world.camera.y = 0;
			
			image.drawMask = drawMask;
			
			super.render();
			
			var g:Graphics = FP.sprite.graphics;
			
			g.clear();
			
			g.lineStyle(3, color);
			
			g.drawEllipse(x - width*0.5, y, width, height);
			
			FP.buffer.draw(FP.sprite);
		}
	}
}

