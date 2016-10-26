package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private var Move:Float = 0;
	private var Multiplier:Float = 20.0;
	private var VYMax:Float;
	private var VXMax:Float;
	private var JumpHeight:Float;
	private var GravityNorm:Float;
	private var GroundAcc:Float;
	private var GroundFric:Float;
	private var AirAcc:Float;
	private var AirFric:Float;
	private var salto:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Player__png, true, 16, 32);
		VYMax       = 11   * Multiplier;
		VXMax       = 6.5  * Multiplier;
		JumpHeight  = 8    * Multiplier;
		GravityNorm = 0.5  * Multiplier;
		GroundAcc   = 1.0  * Multiplier;
		GroundFric  = 1.9  * Multiplier;
		AirAcc      = 0.75 * Multiplier;
		AirFric     = 0.1  * Multiplier;
		
		acceleration.y = Reg.AccGravedad;
		
	}
	override public function update(elapsed:Float):Void
	{	
		if (FlxG.keys.pressed.LEFT) 
			x -= 100 * FlxG.elapsed;
		if (FlxG.keys.pressed.RIGHT) 
			x += 100 * FlxG.elapsed;
		if (FlxG.keys.pressed.UP && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -VYMax;
			animation.add("move", [1, 2], 5, true);
			animation.play("move");
			salto = true;
		}
		else
		{
			animation.add("move2", [0], 4, false);
			animation.play("move2");
			salto = false;
			animation.stop();
		}
		super.update(elapsed);
	}
	public function getSalto(): Bool
	{
		return salto;
	}
	
}