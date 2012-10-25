package
{
	import net.flashpunk.*;
	
	public class AIController extends Controller
	{
		private var paddle: Player;
		
		private var targetY: Number;
		
		public function AIController (_paddle: Player)
		{
			paddle = _paddle;
			
			targetY = FP.height*0.5;
		}
		
		private function findTarget (): void
		{
			var ball:Ball = Level(paddle.world).ball;
			
			var t: Number = (ball.x - paddle.x) / -ball.vx;
			
			if (t > 100 || t < 0) { return; }
			
			targetY += (ball.y + ball.vy * t - targetY) * (1 - t * 0.005) * 0.5;
		}
		
		public override function getDirection (): int
		{
			findTarget();
			
			var size:Number = paddle.height;
			
			var diff: Number = targetY - paddle.y - size*0.5;
			
			if (diff > size / 2)
			{
				return 1;
			}
			else if (diff < -size / 2)
			{
				return -1;
			}
			
			return 0;
		}
	}
}


