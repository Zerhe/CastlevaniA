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
	}
	override public function move() 
	{
		super.move();
		x -= 100 * FlxG.elapsed;
		if (!coliPiso)
			velocity.y = Reg.Approach(velocity.y, VYMax, GravityNorm);
		else
			velocity.y = 0;
	}
	public function OnFloor(value:Bool):Void
	{
		coliPiso = value;
	}
}