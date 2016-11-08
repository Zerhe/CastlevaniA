package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class EnemyBullet extends FlxSprite
{
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(5, 5);
		acceleration.y = Reg.AccGravedad;
		velocity.y = -300;
		velocity.x = direBala();
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	public function direBala():Int
	{
		if (Reg.playerX > x)
			return 100;
		else 
			return -100;
	}
	public function boss(velocidadX:Int)
	{
		makeGraphic(16, 16);
		velocity.y = -500;
		if (velocity.x > 0)
			velocity.x = velocidadX;
		else if (velocity.x < 0)
			velocity.x = -velocidadX;
	}
}