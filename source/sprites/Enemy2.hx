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
		makeGraphic(16, 16, 0xFF00FF00);
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