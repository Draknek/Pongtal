package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Menu extends World
	{
		[Embed(source="images/title.png")] public static const TitleGfx: Class;
		
		public function Menu ()
		{
			addGraphic(new Backdrop(Level.BgGfx, true, true));
			
			var title:Stamp = new Stamp(TitleGfx);
			title.x = (FP.width - title.width)*0.5;
			title.y = 50;
			
			addGraphic(title);
			
			add(new Button("1 Player", 230, function ():void {
				Main.singlePlayer = true;
				FP.world = new Level;
			}));
			add(new Button("2 Player", 280, function ():void {
				Main.singlePlayer = false;
				FP.world = new Level;
			}));
		}
		
		public override function begin (): void
		{
			
		}
		
		public override function end (): void
		{
			Input.mouseCursor = "auto";
		}
		
		public override function update ():void
		{
			Input.mouseCursor = "auto";
			
			super.update();
		}
	}
}

