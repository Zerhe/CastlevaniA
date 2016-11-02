package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class PickUp extends FlxSprite
{
	private var tipo:Int; // 0 vida, 1 alargar, 2 laser
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		tipo = FlxG.random.int(0, 3);
		makeGraphic(10, 10);
	}
	override public function kill(p:Player):Void 
	{
		p.agarrarPickUp(tipo);
		super.kill();
	}
}