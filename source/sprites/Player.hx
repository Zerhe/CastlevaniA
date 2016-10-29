package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.FlxCamera;
/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private var Multiplier:Float = 20.0;
	private var VYMax:Float;
	//private var VXMax:Float;
	//private var GravityNorm:Float;
	private var salto:Bool = false;
	private var direAtq = true;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Player__png, true, 16, 32);
		VYMax       = 11   * Multiplier;
		//VXMax       = 6.5  * Multiplier;
		//GravityNorm = 0.5  * Multiplier;
		
		acceleration.y = Reg.AccGravedad;
		
	}
	override public function update(elapsed:Float):Void
	{	
		if (isTouching(FlxObject.FLOOR))
		{
			velocity.x = 0;
			salto = false;
		}
		if (FlxG.keys.pressed.LEFT && !salto)
		{
			x -= 100 * FlxG.elapsed;
			direAtq = false;
		}
		if (FlxG.keys.pressed.RIGHT && !salto) 
		{
			x += 100 * FlxG.elapsed;
			direAtq = true;
		}	
		if (FlxG.keys.pressed.UP && FlxG.keys.pressed.RIGHT && isTouching(FlxObject.FLOOR))
		{	
			velocity.y = -VYMax;
			velocity.x = 100;
			salto = true;
			trace("xDxDxDDD");
		}
		else if (FlxG.keys.pressed.UP && FlxG.keys.pressed.LEFT && isTouching(FlxObject.FLOOR))
		{	
			velocity.y = -VYMax;
			velocity.x = -100;
			salto = true;
		}
		else if (FlxG.keys.pressed.UP && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -VYMax;
			salto = true;
		}
		
		/*  probando la camara
		if (x > camera.width/4 && x < camera.width / 2 + camera.width / 4)
			camera.scroll.x += 0;
		else if (x > camera.width / 2 + camera.width / 4)
			camera.scroll.x += 1;
		else if (x < camera.width / 4)
			camera.scroll.x -= 1;
		*/
		super.update(elapsed);
	}
	public function getDireAtq(): Bool
	{
		return direAtq;
	}	
}