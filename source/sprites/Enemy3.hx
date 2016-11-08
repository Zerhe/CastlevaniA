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
		loadGraphic(AssetPaths.Enemy3__png, true, 32, 32);
		animation.add("idle", [0, 1], 8, true);
		animation.play("idle");
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