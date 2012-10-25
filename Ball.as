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
		
		public var spawning:Boolean = false;
		
		public function Ball ()
		{
			var image:Image = new Image(Gfx);
			//image.blend = "add";
			image.color = 0xFFFF00;
			//image.scale = 0.5;
			image.smooth = true;
			
			image.centerOrigin();
			
			graphic = image;
			
			setHitbox(r*2, r*2, r, r);
			
			spawn();
		}
		
		public function spawn ():void
		{
			x = oldX = FP.width*0.5;
			y = oldY = FP.height*0.5;
			
			vx = 1 * speed;
			vy = FP.choose(1, -1) * (1 + Math.random()) * speed*0.3;
			
			spawning = true;
			
			var spawnTime:int = 30;
			
			Image(graphic).alpha = 0.0;
			
			FP.tween(graphic, {alpha: 1.0}, spawnTime, function ():void {
				spawning = false;
			});
		}
		
		public override function update (): void
		{
			Audio.loop.volume = 0.5 * Image(graphic).alpha;
			Audio.loop.pan = (x / FP.width) * 2 - 1;
			
			if (spawning) {
				return;
			}
			
			var minSpeed:Number = 1.5;
			
			if (vx > -minSpeed && vx < minSpeed) {
				vx = (vx < 0) ? -1 : 1;
				vx *= minSpeed;
			}
			
			oldX = x;
			oldY = y;
			x += vx;
			y += vy;
			
			if (x + r*2 < 0) {
				Level(world).p2.score++;
				spawn();
				return;
			} else if (x - r*2 > FP.width) {
				Level(world).p1.score++;
				spawn();
				return;
			}
			
			if (y - r < 0) {
				y = r;
				vy *= -1;
				Audio.play("bounce");
			} else if (y + r > FP.height) {
				y = FP.height - r;
				vy *= -1;
				Audio.play("bounce");
			}
		}
	}
}

