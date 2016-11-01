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
	private var direc = true;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.main__png, true, 24, 46);
		animation.add("idle", [0], 1, true);
		animation.add("runR", [2, 3, 4, 5, 6, 7, 8], 5, true);
		animation.add("runL", [9, 10, 11, 12, 13, 14, 15], 5, true);
		VYMax       = 11   * Multiplier;

		
		acceleration.y = Reg.AccGravedad;
		
		
	}
	override public function update(elapsed:Float):Void
	{	
		animation.play("idle");
		if (isTouching(FlxObject.FLOOR))
		{
			velocity.x = 0;
			salto = false;
		}
		if (FlxG.keys.pressed.LEFT && !salto)
		{
			x -= 100 * FlxG.elapsed;
			direc = false;
			animation.play("runL");
		}
		if (FlxG.keys.pressed.RIGHT && !salto) 
		{
			x += 100 * FlxG.elapsed;
			direc = true;
			animation.play("runR");
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
	public function getDirec(): Bool
	{
		return direc;
	}	
}