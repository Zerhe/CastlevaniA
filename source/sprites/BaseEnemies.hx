package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class BaseEnemies extends FlxSprite
{
	private var Multiplier:Float = 20.0;
	private var GravityNorm:Float;
	private var VYMax:Float;
	private var killed:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		GravityNorm = 0.5 * Multiplier;
		VYMax = 13 * Multiplier;
		killed = false;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		move();
		if (this.x > (FlxG.camera.scroll.x + FlxG.camera.width + this.width*2) && this.alive)
			kill();
		else if (this.x < (FlxG.camera.scroll.x - this.width * 2) && this.alive)
			kill();
	}
	public function move(){};
	public function loMataron():Void
	{
		FlxG.sound.play(AssetPaths.explosion__wav);
		killed = true;
		kill();
	}
	public function checkKilled():Bool
	{
		return killed;
	}
	
}