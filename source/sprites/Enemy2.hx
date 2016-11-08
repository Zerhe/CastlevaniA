package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy2 extends BaseEnemies
{
	private var counter:Int;
	private var velMaxY:Float;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Enemy2__png, true, 16, 16);
		animation.add("fly", [0, 1], 8, true);
		animation.play("fly");
		counter = 0;
		velMaxY = 80;
		velocity.y = velMaxY * -1;
	}
	override public function move() 
	{
		super.move();
		counter++;
		velocity.x = -100;
		if (counter == 20)
		{
			velMaxY *= -1;
			velocity.y = velMaxY;
			counter = 0;
		}
	}
}