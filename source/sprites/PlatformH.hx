package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class PlatformH extends FlxSprite
{
	private var counter:Int;
	private var velX:Float = 1;
	public function new(_counter:Int,direcction:String,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PlataformaCastleH__png, true, 48, 16);
		animation.add("idle", [0,1, 2, 3, 4, 5, 6,  5, 4, 3, 2, 1,0,7, 8, 9, 10, 11, 12, 11, 10, 9, 8,7], 20, true);
		animation.play("idle");
		counter = _counter;
		immovable = true;
		if (direcction == "False")
			velX *=-1;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		x += velX;
		if (counter == 96)
		{
			counter = 0;
			velX *= -1;
		}
		counter++;
	
		
	}
	
}