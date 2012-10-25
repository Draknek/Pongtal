package
{
	import net.flashpunk.utils.*;
	
	public class KeyboardController extends Controller
	{
		private var upKey: uint;
		private var downKey: uint;
		
		public function KeyboardController (_up: uint, _down: uint)
		{
			upKey = _up;
			downKey = _down;
		}
		
		public override function getDirection (): int
		{
			var dir: int = 0;
			
			if (Input.check(upKey))   { dir -= 1; }
			if (Input.check(downKey)) { dir += 1; }
			
			return dir;
		}
	}
}


