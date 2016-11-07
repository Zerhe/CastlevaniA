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
		makeGraphic(30, 3);
		kill();
	}
	public function agrandar():Void
	{
		//animation
	}
	public function respawn(direcc:Bool):Void
	{
		revive();
		switch(direcc){
		case true:
			x = Reg.playerX + 15;
			y = Reg.playerY + 15;
		case false:
			x = Reg.playerX - 15;
			y = Reg.playerY + 15;
		}
	}
}