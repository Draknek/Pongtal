package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Ball extends Entity
	{
		public var vx: Number = 0;
		public var vy: Number = 0;
		
		public var r:Number = 10;
		public var speed:Number = 4;
		
		public function Ball ()
		{
			x = FP.width*0.5;
			y = FP.height*0.5;
			
			vx = 1 * speed;
			vy = FP.choose(1, -1) * (1 + Math.random()) * speed*0.5;
			
			var image:Image = Image.createCircle(r, 0xFFFFFF);
			
			image.centerOrigin();
			
			graphic = image;
		}
		
		public override function update (): void
		{
			x += vx;
			y += vy;
			
			if (x - r < 0) {
				x = r;
				vx *= -1;
			} else if (x + r > FP.width) {
				x = FP.width - r;
				vx *= -1;
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

