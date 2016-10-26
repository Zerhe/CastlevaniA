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
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.x = -100;
	}
}