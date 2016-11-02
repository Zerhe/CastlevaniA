package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Laser extends FlxSprite
{
	public function new(direcc:Bool,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 2);
		if (direcc)
			velocity.x = 500;
		else
			velocity.x = -500;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
}