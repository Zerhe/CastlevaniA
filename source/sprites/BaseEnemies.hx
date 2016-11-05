package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BaseEnemies extends FlxSprite
{
	private var Multiplier:Float = 20.0;
	private var GravityNorm:Float;
	private var VYMax:Float;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		GravityNorm = 0.5 * Multiplier;
		VYMax = 13 * Multiplier;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		move();
	}
	public function move(){};
	
}