package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class PlatformV extends FlxSprite
{
	private var counter:Int;
	private var velY:Float = -1;
	public function new(_counter:Int,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.PlatformCastleV__png, true, 48, 16);
		animation.add("idle", [0, 1], 2, true);
		animation.play("idle");
		counter = _counter;
		immovable = true;

	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		y += velY;
		if (counter == 128)
		{
			velY *= -1;
			counter = 0;
		}
		counter++;
	}
}