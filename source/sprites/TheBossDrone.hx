package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class TheBossDrone extends BaseEnemies
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16, 0xFF00FF00);
		immovable = true;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);

		if (x > Reg.playerX)
			velocity.x = -30;
		else if (x < Reg.playerX)
			velocity.x = 30;

		if (y > Reg.playerY)
			velocity.y = -30;
		else if (y < Reg.playerY)
			velocity.y = 30;
	}
}