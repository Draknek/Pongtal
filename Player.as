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
		
		public var controller:Controller;
		
		public var score:int = 0;
		
		public var scoreText:Text;
		
		public function Player (side:int)
		{
			x = FP.width*0.5 + side*(FP.width*0.5 - 40);
			y = FP.height*0.5;
			
			color = (side < 0) ? 0xf17d00 : 0x0270cf;
			
			width = 40;
			height = 100;
			
			y -= height*0.5;
			
			initPortal();
			
			if (side > 0) {
				controller = new KeyboardController(Key.UP, Key.DOWN);
			} else if (Main.singlePlayer) {
				controller = new AIController(this);
			} else {
				controller = new KeyboardController(Key.W, Key.S);
			}
			
			scoreText = new Text("0", x - side * (width) - 50, 20, {align: "center", color: 0x0, size: 24, width: 100});
			scoreText.relative = false;
			
			addGraphic(scoreText);
		}
		
		public function get other ():Player {
			var level:Level = world as Level;
			return (level.p1 == this) ? level.p2 : level.p1;
		}
		
		public override function update (): void
		{
			scoreText.text = score + "";
			
			vy = 3 * controller.getDirection();
			
			y += vy;
			
			var padding:Number = 6;
			
			if (y < padding) {
				y = padding;
				vy = 0;
			} else if (y + height > FP.height - padding) {
				y = FP.height - height - padding;
				vy = 0;
			}
			
			var level:Level = world as Level;
			var ball:Ball = level.ball;
			
			doBounce(ball, x, y);
			doBounce(ball, x, y + height);
		}
		
		public static function doBounce (ball:Ball, _x:Number, _y:Number):void
		{
			var dx:Number = ball.x - _x;
			var dy:Number = ball.y - _y;
			
			var dzSq:Number = dx*dx + dy*dy;
			
			if (dzSq > ball.r*ball.r) return;
			
			var dz:Number = Math.sqrt(dzSq);
			
			dx /= dz;
			dy /= dz;
			
			var overlap:Number = ball.r - dz;
			
			ball.x += dx * overlap;
			ball.y += dy * overlap;
			
			var dir:int = (_x > FP.width*0.5) ? 1 : -1;
			
			var dir2:int = (dx < 0) ? 1 : -1;
			
			if (dir != dir2) return;
			
			var speedTowards:Number = -dx*ball.vx - dy*ball.vy;
			
			if (speedTowards < 0) return;
			
			if (Math.abs(dx) < Math.abs(dy)*1.5) {
				var speedBefore:Number = Math.sqrt(ball.vx*ball.vx + ball.vy*ball.vy);
				
				ball.vx += dx * speedTowards;
				ball.vy += dy * speedTowards;
				
				var speedAfter:Number = Math.sqrt(ball.vx*ball.vx + ball.vy*ball.vy);
				
				ball.vx *= speedBefore / speedAfter;
				ball.vy *= speedBefore / speedAfter;
			} else {
				Audio.play("bounce");
				
				ball.vx += dx * speedTowards * 2.05;
				ball.vy += dy * speedTowards * 2.05;
			}
		}
		
		public function doPortaling (): void
		{
			var level:Level = world as Level;
			var ball:Ball = level.ball;
			
			var y1:Number = y;
			var y2:Number = y + height;
			
			if (ball.y >= y1 && ball.y <= y2) {
				if ((ball.x < x) != (ball.oldX < x)) {
					var dir:int = (other.x < x) ? 1 : -1;
					var dir2:int = (ball.vx > 0) ? 1 : -1;
					
					if (dir != dir2) return;
					
					ball.x += other.x - x;
					ball.y += other.y - y;
					ball.oldX = ball.x;
					ball.oldY = ball.y;
					
					ball.vx += dir * 0.5;
					
					Audio.play("portal");
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

