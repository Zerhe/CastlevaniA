package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Enemy1 extends BaseEnemies
{
	private var coliPiso:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 32);
		acceleration.y = Reg.AccGravedad;
	}
	override public function move() 
	{
		super.move();
		x -= 100 * FlxG.elapsed;
	}
}