package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Ball extends Entity
	{
		[Embed(source="images/ball.png")] public static const Gfx: Class;
		
		public var oldX: Number = 0;
		public var oldY: Number = 0;
		
		public var vx: Number = 0;
		public var vy: Number = 0;
		
		public var r:Number = 10;
		public var speed:Number = 4;
		
		public function Ball ()
		{
			spawn();
			
			var image:Image = new Image(Gfx);
			image.blend = "add";
			image.color = 0xFFFF00;
			image.scale = 0.5;
			image.smooth = true;
			
			image.centerOrigin();
			
			graphic = image;
		}
		
		public function spawn ():void
		{
			x = oldX = FP.width*0.5;
			y = oldY = FP.height*0.5;
			
			vx = -1 * speed;
			vy = FP.choose(1, -1) * (1 + Math.random()) * speed*0.5;
		}
		
		public override function update (): void
		{
			oldX = x;
			oldY = y;
			x += vx;
			y += vy;
			
			if (x + r*2 < 0 || x - r*2 > FP.width) {
				spawn();
				return;
			}
			
			if (y - r < 0) {
				y = r;
				vy *= -1;
			} else if (y + r > FP.height) {
				y = FP.height - r;
				vy *= -1;
			}
		}
	}
}

