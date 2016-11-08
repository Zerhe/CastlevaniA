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
		switch(tipo)
		{
			case 0:
				loadGraphic(AssetPaths.HealthPU__png, false, 10, 10);
			case 1:
				makeGraphic(10, 10);
			case 2:
				loadGraphic(AssetPaths.LaserPU__png, false, 10, 10);
		}
		acceleration.y = Reg.AccGravedad/2;
	}
	public function agarrar(p:Player):Void 
	{
		p.agarrarPickUp(tipo);
		FlxG.sound.play(AssetPaths.powerup__wav);
		destroy();
	}
}