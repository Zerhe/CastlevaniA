package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Ataque extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(15, 3);
		kill();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		x = Reg.playerX + 15;
		y = Reg.playerY + 100;
	}
	public function agrandar():Void
	{
		//animation
	}
}