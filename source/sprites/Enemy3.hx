package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy3 extends BaseEnemies
{
	private var counter:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 32, 0xFF0000FF);
		counter = 0;
		acceleration.y = Reg.AccGravedad;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		counter++;
		if (counter == 60)
		{
			Reg.enemyBullets.add(new EnemyBullet(x, y));
			counter = 0;
		}
	}
}