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
		loadGraphic(AssetPaths.Enemy1__png , true, 24, 32);
		animation.add("run", [0, 1], 8, true);
		animation.play("run");
		acceleration.y = Reg.AccGravedad;
	}
	override public function move() 
	{
		super.move();
		x -= 80 * FlxG.elapsed;
	}
}