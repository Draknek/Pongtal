package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Button extends Entity
	{
		public var image:Image;
		
		public var callback:Function;
		
		public var normalColor:uint = 0xFFFFFF;
		public var hoverColor:uint = 0x0270cf;
		
		public function Button (text:String, _y:int, _callback:Function)
		{
			y = _y;
			
			image = new Text(text, 0, 0, {size: 32});
			
			image.color = normalColor;
			
			graphic = image;
			
			setHitbox(image.width, image.height);
			
			type = "button";
			
			callback = _callback;
			
			x = int((FP.width - image.width) * 0.5);
		}
		
		public override function update (): void
		{
			if (!world || !collidable) return;
			
			var over:Boolean = collidePoint(x, y, world.mouseX, world.mouseY);
			
			if (over) {
				Input.mouseCursor = "button";
			}
			
			image.color = (over) ? hoverColor : normalColor;
			
			if (over && Input.mousePressed && callback != null) {
				callback();
			}
		}
	}
}

